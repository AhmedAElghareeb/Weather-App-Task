import 'package:weather_app/src/core/navigation/app_routes.dart';
import 'package:weather_app/src/core/utils/app_toast.dart';
import 'package:weather_app/src/features/start/splash/splash_screen.dart';
import 'package:weather_app/src/features/weather/presentation/screens/weather_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Global navigator key — used for navigation from anywhere in the app
/// (e.g., interceptors, services) without needing a BuildContext.
/// ─────────────────────────────────────────────────────────────────────────────
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// ─────────────────────────────────────────────────────────────────────────────
/// AppRouter — Centralized routing configuration using GoRouter
/// ─────────────────────────────────────────────────────────────────────────────
/// Provides static helpers for navigation (go, push, pop) and defines
/// the complete route tree of the application.
class AppRouter {
  /// Access the current GoRouter instance from the navigator key context.
  static GoRouter get _router => GoRouter.of(navigatorKey.currentContext!);

  /// Returns true if the router can pop the current route.
  static bool get canPop => _router.canPop();

  /// Navigate to a path, replacing the entire navigation stack.
  static go(String path, {Object? extra}) {
    _router.go(path, extra: extra);
  }

  /// Push a new route onto the navigation stack.
  static Future<T?> push<T extends Object?>(String path, {Object? extra}) {
    return _router.push<T>(path, extra: extra);
  }

  /// Push a named route onto the navigation stack.
  static Future<T?> pushNamed<T extends Object?>(
    String path, {
    Object? extra,
  }) {
    return _router.pushNamed<T>(path, extra: extra);
  }

  /// Replace the current route with a new one.
  static void pushReplacement(String path, {Object? extra}) {
    _router.pushReplacement(path, extra: extra);
  }

  /// Pop the current route. Falls back to the weather screen if can't pop.
  static void pop<T extends Object?>([T? result]) {
    if (_router.canPop()) {
      _router.pop<T>(result);
    } else {
      go(AppRoutes.weather);
    }
  }

  /// Safely pop only if the router can actually pop.
  static void safePop<T extends Object?>([T? result]) {
    if (_router.canPop()) {
      _router.pop<T>(result);
    }
  }

  /// ─────────────────────────────────────────────────────────────────────────
  /// Route Tree Definition
  /// ─────────────────────────────────────────────────────────────────────────
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    observers: [RouteObserver()],
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(body: Center(child: Text('Error: ${state.error}'))),
    ),
    routes: [
      /// Splash screen — animated weather icon intro
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        pageBuilder: (context, state) => const MaterialPage(
          key: ValueKey('splash'),
          child: SplashScreen(),
        ),
      ),

      /// Weather screen — the main feature of the app
      GoRoute(
        path: AppRoutes.weather,
        name: 'weather',
        pageBuilder: (context, state) => const MaterialPage(
          key: ValueKey('weather'),
          child: WeatherScreen(),
        ),
      ),
    ],
  );
}

/// ─────────────────────────────────────────────────────────────────────────────
/// DoubleBackLogic — Handles "press back again to exit" behavior
/// ─────────────────────────────────────────────────────────────────────────────
class DoubleBackLogic {
  static DateTime? _lastTimeBackButtonWasPressed;
  static const Duration _exitTimeDuration = Duration(seconds: 2);

  static Future<bool> onExit(BuildContext context) async {
    final now = DateTime.now();
    final bool isWarningShowing =
        _lastTimeBackButtonWasPressed != null &&
        now.difference(_lastTimeBackButtonWasPressed!) < _exitTimeDuration;
    if (isWarningShowing) {
      await SystemNavigator.pop();
      return true;
    } else {
      _lastTimeBackButtonWasPressed = now;
      _showExitToast(context);
      return false;
    }
  }

  static void _showExitToast(BuildContext context) =>
      AppToast.showWarning(context: context, 'pressAgainToExit'.tr());
}
