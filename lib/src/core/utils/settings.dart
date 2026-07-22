import 'dart:convert';

import 'package:base_structure/src/core/constants/cache_constants.dart';
import 'package:base_structure/src/core/helpers/prefs_helper.dart';
import 'package:base_structure/src/core/network/models/user_model.dart';
import 'package:base_structure/src/core/network/models/user_response_model.dart';
import 'package:easy_localization/easy_localization.dart';

abstract class Settings {
  static Future<String?>? get token async =>
      await SecureStorage.read(CacheConstants.token);

  static Future<UserModel?> get user async {
    final String? userJson = await SecureStorage.read(CacheConstants.user);
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  static String? convertDate({required DateTime? date}) =>
      date != null ? DateFormat('yyyy-MM-dd').format(date) : null;

  static String? generateStatus(String? status) => status?.trim().toLowerCase();

  static void cacheUserData({required UserResponseModel user}) async {
    await SecureStorage.write(CacheConstants.token, user.token!);
    await SecureStorage.write(
      CacheConstants.user,
      jsonEncode(user.user.toJson()),
    );
  }
}
