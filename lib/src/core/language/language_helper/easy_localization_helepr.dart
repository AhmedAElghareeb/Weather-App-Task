import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

abstract class EasyLocalizationHelper {
  static Future<void> changeLanguage(
    BuildContext context, {
    required Locale locale,
  }) async =>
      await EasyLocalization.of(context)?.setLocale(locale);

  static String? currentLanguage(BuildContext context) =>
      EasyLocalization.of(context)?.currentLocale?.languageCode;

  static String? deviceLanguage(BuildContext context) =>
      EasyLocalization.of(context)?.deviceLocale.languageCode;
}

/// Example
//  final isArabic = Locale(LanguageManager.currentLang);
//
// final newLocale = (isArabic) ? const Locale('en') : const Locale('ar');
// final newLangCode = newLocale.languageCode;
//
// await EasyLocalizationHelper.changeLanguage(
//   context,
//   locale: newLocale,
// );
/// Save lang
// CacheHelper.setStringData(
//   key: CacheConstants.language,
//   value: newLangCode,
//);
