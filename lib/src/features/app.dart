import 'package:base_structure/src/core/constants/app_const.dart';
import 'package:base_structure/src/core/navigation/app_router.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:base_structure/src/core/utils/app_theme/app_theme.dart';
import 'package:base_structure/src/core/utils/app_theme/theme_provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    /// To Do Initialize Services ...
    /// Firebase, Pusher, Location
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (cx, child) => BlocProvider(
        create: (context) => ThemeCubit()..init(),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) => RefreshConfiguration(
            headerBuilder: () => const MaterialClassicHeader(),
            footerBuilder: () => ClassicFooter(
              loadStyle: LoadStyle.ShowWhenLoading,
              loadingText: 'loadingMore'.tr(),
              noDataText: '',
              failedText: 'failed'.tr(),
              idleText: 'canLoading'.tr(),
              canLoadingText: 'canLoading'.tr(),
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            headerTriggerDistance: 10,
            maxOverScrollExtent: 50,
            maxUnderScrollExtent: 0,
            enableScrollWhenRefreshCompleted: true,
            enableLoadingWhenFailed: true,
            hideFooterWhenNotFull: false,
            enableBallisticLoad: true,
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: AppConstants.appName,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: themeState.themeMode,
              routerConfig: AppRouter.router,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: const TextScaler.linear(1.0)),
                child: child!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
