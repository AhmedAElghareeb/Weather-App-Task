import 'package:equatable/equatable.dart';

import 'user_model.dart';

class UserResponseModel extends Equatable {
  final String? token;
  final UserModel user;

  const UserResponseModel({
    this.token,
    required this.user,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) =>
      UserResponseModel(
        token: json['token'],
        user: UserModel.fromJson(json['user']),
      );

  @override
  List<Object?> get props => [
        token,
        user,
      ];
}
