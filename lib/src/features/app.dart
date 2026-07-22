import 'package:weather_app/src/core/constants/app_const.dart';
import 'package:weather_app/src/core/navigation/app_router.dart';
import 'package:weather_app/src/core/utils/app_theme/app_theme.dart';
import 'package:weather_app/src/core/utils/app_theme/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// MyApp — The root widget of the Weather App
/// ─────────────────────────────────────────────────────────────────────────────
/// Configures the application-wide settings:
/// - [ScreenUtilInit] for responsive design across different screen sizes
/// - [ThemeCubit] for dynamic light/dark mode switching
/// - [MaterialApp.router] with GoRouter for declarative navigation
/// - [EasyLocalization] delegates for multi-language support
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  /// Placeholder for initializing external services (Firebase, analytics, etc.)
  Future<void> _initializeServices() async {
    /// Add service initialization here as needed
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      /// Design size based on a standard mobile viewport
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (cx, child) => BlocProvider(
        /// ThemeCubit manages light/dark mode preference persistence
        create: (context) => ThemeCubit()..init(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) => MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeState.themeMode,
            routerConfig: AppRouter.router,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            /// Prevent system text scaling from breaking the UI layout
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!,
            ),
          ),
        ),
      ),
    );
  }
}
