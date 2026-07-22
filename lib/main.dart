import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/src/core/helpers/prefs_helper.dart';
import 'package:weather_app/src/core/language/language_helper/language_helper.dart';
import 'package:weather_app/src/core/language/language_helper/language_manager.dart';
import 'package:weather_app/src/core/network/bloc_observer.dart';
import 'package:weather_app/src/core/utils/di.dart';
import 'package:weather_app/src/features/app.dart';

void main() async {
  /// flutter binding
  WidgetsFlutterBinding.ensureInitialized();

  /// orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// init services
  await Future.wait([
    // Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform),
    EasyLocalization.ensureInitialized(),
    CacheStorage.init(),
    ScreenUtil.ensureScreenSize(),
    dotenv.load(fileName: ".env"),
  ]);

  /// di setup
  await setupDi();

  /// bloc observer
  Bloc.observer = AppBlocObserver();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  /// run app
  runApp(
    EasyLocalization(
      supportedLocales: Languages.supportLocales,
      path: 'assets/translations',
      saveLocale: true,
      startLocale: Locale(LanguageManager.currentLang),
      fallbackLocale: const Locale('ar'),
      child: const MyApp(),
    ),
  );
}
