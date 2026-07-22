import 'dart:io';

import 'package:base_structure/src/core/utils/di.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';

abstract class DioManager {
  static final Dio _dio = di<Dio>();

  static Future<Response> get({required String url, Options? options}) async =>
      await _dio.get(url, options: options);

  static Future<Response> post({
    required String url,
    dynamic data,
    Options? options,
  }) async => await _dio.post(url, data: data, options: options);

  static Future<Response> put({
    required String url,
    dynamic data,
    Options? options,
  }) async => await _dio.put(url, data: data, options: options);

  static Future<Response> patch({
    required String url,
    dynamic data,
    Options? options,
  }) async => await _dio.patch(url, data: data, options: options);

  static Future<Response> delete({
    required String url,
    dynamic data,
    Options? options,
  }) async => await _dio.delete(url, data: data, options: options);

  static Future<Response> download({
    required String url,
    required String filePath,
  }) async => await _dio.download(
    url,
    filePath,
    onReceiveProgress: (received, total) {
      if (total <= 0) return;
      if (kDebugMode) {
        print('percentage: ${(received / total * 100).toStringAsFixed(0)}%');
      }
    },
  );

  static Future<Response> uploadImage({
    required File image,
    required String url,
    required Map<String, dynamic> data,
    required String imageJsonKey,
    Options? options,
  }) async {
    final String fileName = image.path.split('/').last;
    final multiPartFile = await MultipartFile.fromFile(
      image.path,
      filename: fileName,
    );
    final FormData formData = FormData.fromMap(data);
    formData.files.add(MapEntry(imageJsonKey, multiPartFile));
    return await post(url: url, data: formData, options: options);
  }

  static Future<MultipartFile> multiPartFile({required File file}) async {
    final String fileName = file.path.split('/').last;
    final MultipartFile multiPartFile = await MultipartFile.fromFile(
      file.path,
      filename: fileName,
    );
    return multiPartFile;
  }

  static Future<Response> uploadMultipleFile({
    required String url,
    required List<File> images,
    required Map<String, dynamic> data,
    required String imagesJsonKey,
    Options? options,
  }) async {
    final FormData formData = FormData.fromMap(data);
    for (File item in images) {
      final String fileName = item.path.split('/').last;
      final multipartFile = await MultipartFile.fromFile(
        item.path,
        filename: fileName,
      );
      formData.files.addAll([MapEntry(imagesJsonKey, multipartFile)]);
    }
    return await post(url: url, data: formData, options: options);
  }

  static String getStatusExceptionMessage({
    required Response? response,
    String? error,
  }) {
    switch (response?.statusCode) {
      case 400:
        return error ?? 'BadRequestFailure'.tr();
      case 401:
        return error ?? 'UnauthorizedFailure'.tr();
      case 403:
        return error ?? 'ForbiddenFailure'.tr();
      case 404:
        return error ?? 'NotFoundFailure'.tr();
      case 409:
        return error ?? 'ConflictFailure'.tr();
      case 500:
        return error ?? 'InternalServerErrorFailure'.tr();
      case 503:
        return error ?? 'ServiceUnavailableFailure'.tr();
      default:
        return error ?? 'UnknownFailure'.tr();
    }
  }

  static String getDioExceptionMessage({
    required DioExceptionType dioExceptionType,
    Response? response,
    String? error,
  }) {
    switch (dioExceptionType) {
      case DioExceptionType.badCertificate:
        return 'BadCertificateFailure'.tr();
      case DioExceptionType.connectionTimeout:
        return 'ConnectTimeoutFailure'.tr();
      case DioExceptionType.connectionError:
        return 'ConnectionErrorFailure'.tr();
      case DioExceptionType.sendTimeout:
        return 'SendTimeoutFailure'.tr();
      case DioExceptionType.receiveTimeout:
        return 'ReceiveTimeoutFailure'.tr();
      case DioExceptionType.badResponse:
        return getStatusExceptionMessage(response: response, error: error);
      case DioExceptionType.cancel:
        return 'CancelRequestFailure'.tr();
      case DioExceptionType.unknown:
        return 'UnKnownFailure'.tr();
    }
  }
}
