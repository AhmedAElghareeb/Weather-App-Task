import 'package:base_structure/src/core/components/buttons/custom_loading_button_widget.dart';
import 'package:base_structure/src/core/helpers/loction_bg_service.dart';
import 'package:base_structure/src/core/utils/app_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LatLng? lastSentPosition;
  LocationData? currentLocation;
  bool trackingEnabled = false;
  bool showPermissionRequestUI = false;

  @override
  void initState() {
    super.initState();
    _handlePermissions();
  }

  Future<void> _handlePermissions() async {
    await LocationBackgroundService.handlePermission(
      onError: (message) => _showPermissionError(message),
      onTrackingStart: () => _startTracking(),
    );
  }

  void _startTracking() {
    try {
      LocationBackgroundService.startSubscription(
        onUpdate: (location) => _updateLocation(location),
        onError: (e) {
          trackingEnabled = false;
          _showToast('failedToStartTracking'.tr());
        },
      );
      trackingEnabled = true;
      setState(() {});
    } catch (e) {
      trackingEnabled = false;
      _showToast('failedToStartTracking'.tr());
    }
  }

  void _updateLocation(LocationData location) {
    currentLocation = location;
    lastSentPosition = LatLng(location.latitude!, location.longitude!);
  }

  void _showPermissionError(String message) {
    showPermissionRequestUI = true;
    _showToast(message);
    setState(() {});
  }

  void _showToast(String message) {
    debugPrint(message);
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }

  void setShowPermissionUI(bool value) {
    showPermissionRequestUI = value;
    setState(() {});
  }

  Future<void> checkAndRequestLocationPermission() async {
    final status = await perm.Permission.location.status;

    if (status.isGranted) {
      await _handlePermissions();
    } else if (status.isDenied) {
      final requestResult = await perm.Permission.location.request();
      if (requestResult.isGranted) {
        await _handlePermissions();
      } else {
        setShowPermissionUI(true);
      }
    } else if (status.isPermanentlyDenied) {
      setShowPermissionUI(true);
      _showToast("locationPermissionPermanentlyDenied".tr());
      await perm.openAppSettings();
    } else {
      setShowPermissionUI(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 24,
            vertical: 100,
          ),
          child: Column(
            children: [
              LoadingButton(
                title: 'Start Location Tracking',
                margin: EdgeInsets.zero,
                onTap: () async {
                  await Future.delayed(const Duration(seconds: 3)).then((_) {
                    _handlePermissions();
                    AppToast.showSuccess('Start Tracking Stopped');
                  });
                },
              ),
              const SizedBox(height: 20),
              LoadingButton(
                title: 'Stop Location Tracking',
                margin: EdgeInsets.zero,
                onTap: () async {
                  await Future.delayed(const Duration(seconds: 3)).then((_) {
                    LocationBackgroundService.stopLocationTracking();
                    AppToast.showSuccess('Location Tracking Stopped');
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
