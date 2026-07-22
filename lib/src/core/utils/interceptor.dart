import 'package:base_structure/src/core/navigation/app_router.dart';
import 'package:base_structure/src/core/navigation/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppInterceptor extends Interceptor {
  static final AppInterceptor _instance = AppInterceptor._internal();

  factory AppInterceptor() => _instance;

  AppInterceptor._internal();

  bool isUnauthorized = false;

  void resetUnauthorized() {
    debugPrint('Logger Interceptor => $isUnauthorized');
    isUnauthorized = false;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (isUnauthorized) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: "Unauthorized - Stopping all further requests.",
          type: DioExceptionType.cancel,
        ),
      );
    }

    debugPrint("⚡ API Headers → ${options.headers}");

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final status = err.response?.statusCode;

    if (status == 401
    // || status == 403
    ) {
      if (!isUnauthorized) {
        isUnauthorized = true;
        AppRouter.go(AppRoutes.login);
      }
      return;
    }

    return handler.next(err);
  }
}
