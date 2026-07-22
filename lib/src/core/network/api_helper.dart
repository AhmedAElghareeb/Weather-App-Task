// import 'package:flutter/foundation.dart';

import 'package:base_structure/src/core/network/dio_manager.dart';
import 'package:base_structure/src/core/network/models/api_response_model.dart';
import 'package:base_structure/src/core/network/models/error_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

mixin ApiHelper<T> {
  Future<Either<ErrorModel, X>> handleApiRequest<X>(
    Future<X> Function() apiCall,
  ) async {
    try {
      return Right(await apiCall());
    } on DioException catch (exception) {
      // if (kDebugMode) rethrow;
      final String dioMessage = DioManager.getDioExceptionMessage(
        dioExceptionType: exception.type,
        response: exception.response,
        error: _extractMessage(exception.response?.data),
      );
      return Left(
        ErrorModel(
          message: dioMessage,
          code: exception.response?.statusCode?.toString(),
        ),
      );
    } catch (e) {
      // if (kDebugMode) rethrow;
      return Left(ErrorModel(message: e.toString()));
    }
  }

  T handleResponseError(Response response, int resultStatusCode, T? value) {
    try {
      if (response.statusCode == resultStatusCode) {
        return value!;
      } else {
        final String dioMessage = DioManager.getStatusExceptionMessage(
          response: response,
          error: response.data['message'],
        );
        final ApiResponseModel<String> errorResponse =
            ApiResponseModel<String>.fromJson(response.data, (json) => json);
        throw ErrorModel(message: errorResponse.message ?? dioMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  String handleQueryParams({required Map<String, String?> queryParams}) {
    final String queryString = queryParams.entries
        .where((entry) => entry.value != null)
        .map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value!)}')
        .join('&');

    return queryString;
  }

  String? _extractMessage(dynamic data) {
    if (data == null) return null;

    if (data is String) return data;

    if (data is List) {
      return data.whereType<String>().join('\n');
    }

    if (data is Map) {
      if (data['errors'] != null && data['errors'] is Map) {
        final buffer = StringBuffer();
        final errors = data['errors'] as Map;

        errors.forEach((key, value) {
          if (value is List) {
            for (var item in value) {
              buffer.writeln('• $item');
            }
          } else if (value is String) {
            buffer.writeln('• $value');
          }
        });

        if (buffer.isNotEmpty) {
          return buffer.toString().trim();
        }
      }

      if (data['message'] is String) return data['message'];
      if (data['error'] is String) return data['error'];
      if (data['data'] is String) return data['data'];

      if (data['message'] is Map || data['message'] is List) {
        return _extractMessage(data['message']);
      }
      if (data['error'] is Map || data['error'] is List) {
        return _extractMessage(data['error']);
      }
      if (data['data'] is Map || data['data'] is List) {
        return _extractMessage(data['data']);
      }

      final buffer = StringBuffer();
      data.forEach((key, value) {
        if (value is List) {
          buffer.writeln('$key: ${value.join(', ')}');
        } else if (value is String) {
          buffer.writeln('$key: $value');
        }
      });
      return buffer.toString().trim();
    }

    return data.toString();
  }
}
