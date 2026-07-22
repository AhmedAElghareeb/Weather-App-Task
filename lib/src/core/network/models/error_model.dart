import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final String? code;
  final String? message;

  const ErrorModel({
    this.message,
    this.code,
  });

  ErrorModel copyWith({
    String? code,
    String? message,
  }) =>
      ErrorModel(
        code: code ?? this.code,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        code,
        message,
      ];
}
