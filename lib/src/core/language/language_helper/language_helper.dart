import 'package:base_structure/src/core/language/language_helper/language_manager.dart';
import 'package:base_structure/src/core/navigation/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum Languages {
  english(Locale('en'), 'English', 'en'),
  arabic(Locale('ar'), 'Arabic', 'ar');

  final String title;
  final Locale locale;
  final String languageCode;

  const Languages(this.locale, this.title, this.languageCode);

  static List<Locale> get supportLocales =>
      Languages.values.map((e) => e.locale).toList();

  static List<String> get titles =>
      Languages.values.map((e) => e.title).toList();

  static setLocale(Languages lang) {
    navigatorKey.currentContext!.setLocale(lang.locale);
  }

  static setLocaleWithContext(BuildContext context, Languages lang) {
    context.setLocale(lang.locale);
    LanguageManager.setLang(lang.locale.languageCode);
  }

  static String getLanguageCode(Languages language) {
    return language.locale.languageCode;
  }

  static Languages get currentLanguage {
    final currentLocale = EasyLocalization.of(
      navigatorKey.currentContext!,
    )!.locale;
    return Languages.values.firstWhere(
      (element) => element.locale == currentLocale,
    );
  }
}
