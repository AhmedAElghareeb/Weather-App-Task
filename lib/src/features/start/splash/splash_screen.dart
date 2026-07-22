import 'package:easy_localization/easy_localization.dart';
import 'package:weather_app/src/core/navigation/app_router.dart';
import 'package:weather_app/src/core/navigation/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// SplashScreen — The app's entry point with a weather-themed animation
/// ─────────────────────────────────────────────────────────────────────────────
/// Displays an animated weather icon (cloud with sun) and the app name,
/// then automatically navigates to the Weather screen after a short delay.
/// Uses Flutter's built-in animation system for smooth fade/scale transitions.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  /// Animation controller for the main icon and text fade-in/scale effect.
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  /// Animation controller for the floating cloud motion.
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    /// Fade and scale animation — runs once over 1.2 seconds
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.elasticOut),
    );

    /// Floating animation — loops continuously for a "breathing" effect
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );
    _floatController.repeat(reverse: true);

    /// Start the fade animation
    _fadeController.forward();

    /// Navigate to the weather screen after a 2.5 second delay
    _navigateToWeather();
  }

  /// Waits for the splash animation to play, then navigates to the main screen.
  Future<void> _navigateToWeather() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      AppRouter.go(AppRoutes.weather);
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /// Full-screen gradient matching the weather theme
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A90E2), Color(0xFF50E3C2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Floating weather icon with animated vertical bounce
                  AnimatedBuilder(
                    animation: _floatAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _floatAnimation.value),
                        child: child,
                      );
                    },
                    child: _buildWeatherIcon(),
                  ),

                  SizedBox(height: 32.h),

                  /// App name
                  Text(
                    'weather.title'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IBMPlexSansArabic',
                      letterSpacing: 1.5,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  /// Subtitle
                  Text(
                    'weather.subtitle'.tr(),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'IBMPlexSansArabic',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a composite weather icon using Flutter's built-in icons.
  /// Uses a Stack to layer a cloud and sun icon for a recognizable
  /// weather-themed visual without needing external assets.
  Widget _buildWeatherIcon() {
    return SizedBox(
      width: 120.w,
      height: 120.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          /// Sun icon — positioned slightly to the upper right
          Positioned(
            top: 5.h,
            right: 5.w,
            child: Icon(
              Icons.wb_sunny_rounded,
              color: Colors.amber.shade300,
              size: 60.sp,
            ),
          ),

          /// Cloud icon — positioned in the center-left foreground
          Positioned(
            bottom: 10.h,
            left: 0,
            child: Icon(
              Icons.cloud_rounded,
              color: Colors.white,
              size: 80.sp,
            ),
          ),
        ],
      ),
    );
  }
}
