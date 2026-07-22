import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

class LocationBackgroundService {
  static final Location _location = Location();

  static Location get locationInstance => _location;
  static StreamSubscription<LocationData>? _subscription;
  static void Function(LocationData)? onLocationUpdate;

  // static final CommonModuleRepo _commonService = di<CommonModuleImpl>();

  static Future<void> handlePermission({
    required void Function(String message) onError,
    required void Function() onTrackingStart,
  }) async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) {
          onError("locationServiceDisabled".tr());
          return;
        }
      }

      PermissionStatus permissionGranted = await _location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await _location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          onError("locationPermissionDenied".tr());
          return;
        }
      }

      if (permissionGranted == PermissionStatus.deniedForever) {
        onError("locationPermissionDenied".tr());
        await perm.openAppSettings();
        return;
      }

      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.grantedLimited) {
        await _configureAndEnableBackgroundMode();
      }

      await _location.changeSettings(
        interval: kDebugMode ? 1000 : 5000,
        distanceFilter: kDebugMode ? 1.0 : 20.0,
        accuracy: LocationAccuracy.high,
      );

      onTrackingStart();
    } catch (e, stackTrace) {
      debugPrint('Exception in LocationPermissionService: $e');
      debugPrint('Stack trace: $stackTrace');
      onError('errorCheckingPermissions'.tr());
    }
  }

  static void startSubscription({
    required void Function(LocationData) onUpdate,
    required void Function(dynamic) onError,
  }) {
    _subscription?.cancel();
    onLocationUpdate = onUpdate;
    _subscription = _location.onLocationChanged.listen(
      (location) async {
        if (location.latitude == null || location.longitude == null) return;
        onUpdate.call(location);
      },
      onError: (e) {
        debugPrint('Location stream error: $e');
        onError.call(e);
      },
    );
    debugPrint('✅ Location subscription started');
  }

  // static Future<void> _sendToServer(double lat, double lng) async {
  //   final result = await _commonService.updateLocation(
  //     lat: lat.toString(),
  //     lng: lng.toString(),
  //   );
  //   result.fold(
  //     (left) => debugPrint('❌ Location send failed: ${left.message}'),
  //     (right) => debugPrint('✅ Location sent: $lat, $lng'),
  //   );
  // }

  static void cancelSubscription() => stopLocationTracking();

  static Future<void> _configureAndEnableBackgroundMode() async {
    try {
      if (Platform.isAndroid) {
        final bgStatus = await perm.Permission.locationAlways.request();
        if (!bgStatus.isGranted) {
          debugPrint(
            'Background location permission not granted — foreground only',
          );
          return;
        }
      }

      await _location.enableBackgroundMode(enable: true);

      if (Platform.isAndroid) {
        await _location.changeNotificationOptions(
          title: 'trackingLocation'.tr(),
          subtitle: 'trackingInBackground'.tr(),
          description: 'keepLocationUpdated'.tr(),
          iconName: "@mipmap/ic_launcher",
          onTapBringToFront: true,
          // color: AppColors.primaryColor,
        );
      } else if (Platform.isIOS) {
        await _location.changeNotificationOptions(
          title: 'trackingLocation'.tr(),
          subtitle: 'trackingInBackground'.tr(),
        );
      }
    } catch (e) {
      debugPrint("Could not enable background mode: $e");
    }
  }

  static Future<void> stopLocationTracking() async {
    try {
      onLocationUpdate = null;
      await _subscription?.cancel();
      _subscription = null;

      final bool isEnabled = await _location.isBackgroundModeEnabled();
      if (isEnabled) {
        debugPrint("Disabling background location mode...");
        await _location.enableBackgroundMode(enable: false);
        debugPrint("Background location mode disabled.");
      }
    } catch (e) {
      debugPrint("Error stopping location tracking: $e");
    }
  }
}
