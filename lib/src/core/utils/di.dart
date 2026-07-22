import 'package:base_structure/src/core/navigation/app_router.dart';
import 'package:base_structure/src/core/network/api_endpoints.dart';
import 'package:base_structure/src/core/utils/interceptor.dart';
import 'package:base_structure/src/core/utils/settings.dart';
import 'package:base_structure/src/features/auth/data/service/auth_services.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt di = GetIt.I;

Future<void> setupDi() async {
  setupServiceDi();

  final prefs = await SharedPreferences.getInstance();

  di.registerLazySingleton<SharedPreferences>(() => prefs);
  di.registerLazySingleton<FilePicker>(() => FilePicker.platform);
  di.registerLazySingleton<ImagePicker>(() => ImagePicker());

  final token = Settings.token;
  if (kDebugMode) {
    di.registerLazySingleton<PrettyDioLogger>(() => PrettyDioLogger());
    di.registerLazySingleton<Dio>(
      () =>
          Dio(
              BaseOptions(
                baseUrl: ApiEndpoints.baseUrl,
                contentType: 'application/json',
                headers: {
                  'Accept-Language':
                      (navigatorKey.currentContext!.locale.languageCode == 'ar')
                      ? 'ar'
                      : 'en',
                  'Accept-device': 'mobile',
                  'Authorization': token != null ? 'Bearer $token' : '',
                },
              ),
            )
            ..interceptors.addAll([
              di<PrettyDioLogger>(),
              LanguageInterceptor(),
              AppInterceptor(),
            ]),
    );
  } else {
    di.registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: ApiEndpoints.baseUrl,
          contentType: 'application/json',
          headers: {
            'Accept-Language':
                (navigatorKey.currentContext!.locale.languageCode == 'ar')
                ? 'ar'
                : 'en',
            'Accept-device': 'mobile',
            'Authorization': token != null ? 'Bearer $token' : '',
          },
        ),
      )..interceptors.addAll([LanguageInterceptor(), AppInterceptor()]),
    );
  }
}

class LanguageInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] =
        (navigatorKey.currentContext!.locale.languageCode == 'ar')
        ? 'ar'
        : 'en';

    return handler.next(options);
  }
}

/// Service && Cubit

void setupServiceDi() {
  di.registerLazySingleton<AuthServicesImpl>(() => AuthServicesImpl());

  /// add more service here
}

void setupCubitDi() {
  /// add cubits here ...
}
