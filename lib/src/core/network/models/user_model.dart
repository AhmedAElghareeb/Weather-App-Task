import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? mobileCountryCode;
  final String? mobile;
  final String? status;
  final String? fullName;

  const UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.mobileCountryCode,
    this.mobile,
    this.status,
    this.fullName,
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? mobileCountryCode,
    String? mobile,
    String? status,
    String? fullName,
  }) =>
      UserModel(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
        email: email ?? this.email,
        mobileCountryCode: mobileCountryCode ?? this.mobileCountryCode,
        mobile: mobile ?? this.mobile,
        status: status ?? this.status,
        fullName: fullName ?? this.fullName,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        username: json['username'],
        email: json['email'],
        mobileCountryCode: json['mobile_country_code'],
        mobile: json['mobile'],
        status: json['status'],
        fullName: json['full_name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'first_name': firstName,
        'last_name': lastName,
        'username': username,
        'email': email,
        'mobile_country_code': mobileCountryCode,
        'mobile': mobile,
        'status': status,
        'full_name': fullName,
      };

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        username,
        email,
        mobileCountryCode,
        mobile,
        status,
        fullName,
      ];
}
