import 'package:base_structure/src/core/constants/cache_constants.dart';
import 'package:base_structure/src/core/helpers/prefs_helper.dart';

class LanguageManager {
  static String _currentLang = 'ar';

  static String get currentLang => _currentLang;

  static void init() {
    _currentLang = CacheStorage.read(CacheConstants.language) ?? 'ar';
  }

  static void setLang(String langCode) {
    _currentLang = langCode;
    CacheStorage.write(CacheConstants.language, langCode);
  }
}
