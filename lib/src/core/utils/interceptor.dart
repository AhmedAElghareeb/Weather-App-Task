import 'package:weather_app/src/core/navigation/app_router.dart';
import 'package:weather_app/src/core/navigation/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// AppInterceptor — Global HTTP request/response interceptor
/// ─────────────────────────────────────────────────────────────────────────────
/// Handles cross-cutting concerns like unauthorized access detection.
/// Uses singleton pattern to maintain state across all requests.
class AppInterceptor extends Interceptor {
  static final AppInterceptor _instance = AppInterceptor._internal();

  factory AppInterceptor() => _instance;

  AppInterceptor._internal();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    debugPrint("⚡ API Headers → ${options.headers}");

    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    return handler.next(err);
  }
}
