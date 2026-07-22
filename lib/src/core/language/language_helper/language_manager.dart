import 'package:weather_app/src/core/constants/cache_constants.dart';
import 'package:weather_app/src/core/helpers/prefs_helper.dart';

class LanguageManager {
  static String _currentLang = 'en';

  static String get currentLang => _currentLang;

  static void init() {
    _currentLang = CacheStorage.read(CacheConstants.language) ?? 'en';
  }

  static void setLang(String langCode) {
    _currentLang = langCode;
    CacheStorage.write(CacheConstants.language, langCode);
  }
}
