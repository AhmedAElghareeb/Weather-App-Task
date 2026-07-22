import 'package:weather_app/src/core/navigation/app_router.dart';
import 'package:weather_app/src/core/utils/interceptor.dart';
import 'package:weather_app/src/features/weather/data/service/weather_service.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// Dependency Injection Container
/// ─────────────────────────────────────────────────────────────────────────────
/// Uses [GetIt] as a service locator for managing singletons and factories.
/// All dependencies are registered once at app startup via [setupDi].
final GetIt di = GetIt.I;

/// Entry point for registering all dependencies.
/// Called once from [main()] before the app starts.
Future<void> setupDi() async {
  /// Register feature-level services first
  setupServiceDi();

  /// SharedPreferences — for caching weather data and theme preferences
  final prefs = await SharedPreferences.getInstance();
  di.registerLazySingleton<SharedPreferences>(() => prefs);

  /// Dio — HTTP client configured for the app's own API (if needed in future).
  /// In debug mode, includes PrettyDioLogger for request/response inspection.
  if (kDebugMode) {
    di.registerLazySingleton<PrettyDioLogger>(() => PrettyDioLogger());
    di.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          contentType: 'application/json',
          headers: const {
            'Accept-Language': 'en',
          },
        ),
      )..interceptors.addAll([
          di<PrettyDioLogger>(),
          LanguageInterceptor(),
          AppInterceptor(),
        ]),
    );
  } else {
    di.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          contentType: 'application/json',
          headers: const {
            'Accept-Language': 'en',
          },
        ),
      )..interceptors.addAll([LanguageInterceptor(), AppInterceptor()]),
    );
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// LanguageInterceptor — Updates Accept-Language header on every request
/// ─────────────────────────────────────────────────────────────────────────────
class LanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final context = navigatorKey.currentContext;
    if (context != null) {
      options.headers['Accept-Language'] =
          (context.locale.languageCode == 'ar') ? 'ar' : 'en';
    } else {
      options.headers['Accept-Language'] = 'en';
    }

    return handler.next(options);
  }
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Service Registration
/// ─────────────────────────────────────────────────────────────────────────────
/// Register all feature-level services here. Each service is a lazy singleton,
/// meaning it is only instantiated when first accessed.
void setupServiceDi() {
  /// Weather feature service — handles API calls and caching
  di.registerLazySingleton<WeatherServiceImpl>(() => WeatherServiceImpl());
}

/// ─────────────────────────────────────────────────────────────────────────────
/// Cubit Registration (if needed for global cubits)
/// ─────────────────────────────────────────────────────────────────────────────
void setupCubitDi() {
  /// Add cubits here if they need to be globally accessible
}
