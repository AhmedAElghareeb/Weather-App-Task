import 'package:base_structure/src/core/network/models/pagination_model.dart';

class ApiResponseModel<T> {
  final String? code;
  final String? status;
  final String? message;
  PaginationModel? pagination;
  final T? data;

  ApiResponseModel({
    this.code,
    this.status,
    this.message,
    this.pagination,
    required this.data,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return ApiResponseModel<T>(
      code: json['code']?.toString(),
      status: json['status'] as String?,
      message: json['message'] != null ? json['message'] as String : null,
      pagination: json['paginate'] != null
          ? PaginationModel.fromJson(json['paginate'])
          : null,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'status': status, 'message': message, 'data': data};
  }
}

// Example usage:
// BaseResponse<User> successResponse = BaseResponse<User>.fromJson(successResponseJson, (json) => User.fromJson(json));
// BaseResponse<dynamic> errorResponse = BaseResponse<dynamic>.fromJson(errorResponseJson, (json) => json);
//"pagination": {
//  "total": 7,
//  "per_page": 10,
//  "current_page": 1,
//  "last_page": 1
// },
