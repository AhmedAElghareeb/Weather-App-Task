import 'package:base_structure/src/core/navigation/app_routes.dart';
import 'package:base_structure/src/core/utils/app_toast.dart';
import 'package:base_structure/src/features/auth/presentation/login/login_screen.dart';
import 'package:base_structure/src/features/layout/layout_screen.dart';
import 'package:base_structure/src/features/start/on_boarding/on_boarding_screen.dart';
import 'package:base_structure/src/features/start/splash/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  // static GoRouter createRouter(GoRouter router) {
  //   return router;
  // }

  static GoRouter get _router => GoRouter.of(navigatorKey.currentContext!);

  static bool get canPop => _router.canPop();

  static go(String path, {Object? extra}) {
    _router.go(path, extra: extra);
  }

  static Future<T?> push<T extends Object?>(String path, {Object? extra}) {
    return _router.push<T>(path, extra: extra);
  }

  static Future<T?> pushNamed<T extends Object?>(String path, {Object? extra}) {
    return _router.pushNamed<T>(path, extra: extra);
  }

  static void pushReplacement(String path, {Object? extra}) {
    _router.pushReplacement(path, extra: extra);
  }

  static void pop<T extends Object?>([T? result]) {
    if (_router.canPop()) {
      _router.pop<T>(result);
    } else {
      go(AppRoutes.layout, extra: {'index': 0});
    }
    // GoRouter.of(NavigationService.currentContext!).pop<T>(result);
  }

  static void safePop<T extends Object?>([T? result]) {
    if (_router.canPop()) {
      _router.pop<T>(result);
    }
  }

  static void goToLayout({int index = 0}) =>
      go(AppRoutes.layout, extra: {'index': index});

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
      GoRoute(
        path: AppRoutes.splash,
        name: 'splash',
        pageBuilder: (context, state) =>
            const MaterialPage(key: ValueKey('splash'), child: SplashScreen()),
      ),
      GoRoute(
        path: AppRoutes.onBoarding,
        name: 'onBoarding',
        pageBuilder: (context, state) => const MaterialPage(
          key: ValueKey('onBoarding'),
          child: OnBoardingScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.layout,
        name: 'layout',
        pageBuilder: (context, state) {
          final data = state.extra as Map<String, dynamic>;
          return MaterialPage(
            key: const ValueKey('layout'),
            child: LayoutScreen(index: data['index'] as int),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        pageBuilder: (context, state) =>
            const MaterialPage(key: ValueKey('login'), child: LoginScreen()),
      ),
    ],
  );
}

class DoubleBackLogic {
  static DateTime? _lastTimeBackButtonWasPressed;
  static const Duration _exitTimeDuration = Duration(seconds: 2);
  static OverlayEntry? _exitToast;

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

  static void _removeExitToast() {
    _exitToast?.remove();
    _exitToast = null;
  }

  static void _showExitToast(BuildContext context) =>
      AppToast.showWarning(context: context, 'pressAgainToExit'.tr());
}
