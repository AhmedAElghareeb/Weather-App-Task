import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(fontFamily: 'IBMPlexSansArabic');
    // const colors = lightColors; // Use the light colors instance
    //
    // return ThemeData(
    //   useMaterial3: false,
    //   brightness: Brightness.light,
    //   primaryColor: colors.primary,
    //   scaffoldBackgroundColor: colors.background,
    //   fontFamily: 'Cairo',
    //   extensions: const <ThemeExtension<dynamic>>[colors],
    //   progressIndicatorTheme: const ProgressIndicatorThemeData(
    //     color: colors.primary,
    //   ),
    //   appBarTheme: AppBarTheme(
    //     elevation: 0,
    //     backgroundColor: colors.background,
    //     foregroundColor: colors.text,
    //     surfaceTintColor: colors.primary,
    //     iconTheme: const IconThemeData(size: 20.0, color: colors.text),
    //     centerTitle: true,
    //     titleTextStyle: TextStyle(
    //       fontSize: 20.sp,
    //       color: colors.textSubtle,
    //       fontWeight: FontWeight.w600,
    //       fontFamily: 'Cairo',
    //     ),
    //   ),
    //   bottomSheetTheme: const BottomSheetThemeData(
    //     backgroundColor: colors.card,
    //     surfaceTintColor: Colors.transparent,
    //   ),
    //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //     backgroundColor: colors.card,
    //     selectedItemColor: AppColors.secondary,
    //     unselectedItemColor: colors.textSubtle,
    //     selectedLabelStyle: TextStyle(
    //       fontSize: 12.sp,
    //       fontWeight: FontWeight.w600,
    //       color: AppColors.secondary,
    //     ),
    //     unselectedLabelStyle: TextStyle(
    //       fontSize: 12.sp,
    //       fontWeight: FontWeight.w600,
    //       color: colors.textSubtle,
    //     ),
    //   ),
    //   dialogTheme: DialogThemeData(
    //     backgroundColor: colors.card,
    //     surfaceTintColor: colors.card,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(AppRadius.bR15)),
    //   ),
    //   elevatedButtonTheme: ElevatedButtonThemeData(
    //       style: ElevatedButton.styleFrom(
    //     backgroundColor: colors.primary,
    //     foregroundColor: colors.textInverse,
    //     minimumSize: Size(323.w, 54.h),
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(AppRadius.bR8)),
    //   )),
    //   outlinedButtonTheme: OutlinedButtonThemeData(
    //       style: OutlinedButton.styleFrom(
    //     backgroundColor: colors.background,
    //     minimumSize: Size(323.w, 54.h),
    //     side: const BorderSide(color: colors.primary),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(AppRadius.bR8),
    //     ),
    //   )),
    //   inputDecorationTheme: InputDecorationTheme(
    //     filled: true,
    //     fillColor: colors.card,
    //     isDense: true,
    //     hintStyle: TextStyle(
    //       color: colors.textSubtle,
    //       fontSize: 12.sp,
    //       fontWeight: FontWeight.w400,
    //     ),
    //     contentPadding: EdgeInsets.symmetric(
    //       vertical: AppRadius.bR10,
    //       horizontal: AppSize.sW16,
    //     ),
    //     enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(AppRadius.bR8),
    //       borderSide: const BorderSide(color: colors.border, width: 1),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(AppRadius.bR8),
    //       borderSide: const BorderSide(color: colors.primary, width: 1.5),
    //     ),
    //     errorBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(AppRadius.bR8),
    //       borderSide: const BorderSide(color: colors.error, width: 1),
    //     ),
    //     focusedErrorBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(AppRadius.bR8),
    //       borderSide: const BorderSide(color: colors.error, width: 1.5),
    //     ),
    //   ),
    //   textTheme: _getTextTheme(colors),
    // );
  }

  static ThemeData get dark {
    return ThemeData(fontFamily: 'IBMPlexSansArabic');
    // const colors = darkColors; // Use the dark colors instance
    //
    // return ThemeData(
    //   useMaterial3: false,
    //   brightness: Brightness.dark,
    //   primaryColor: colors.primary,
    //   scaffoldBackgroundColor: colors.background,
    //   fontFamily: 'Cairo',
    //   extensions: const <ThemeExtension<dynamic>>[
    //     colors,
    //   ],
    //   appBarTheme: AppBarTheme(
    //     elevation: 0,
    //     backgroundColor: colors.card,
    //     foregroundColor: colors.text,
    //     surfaceTintColor: AppColors.primary,
    //     iconTheme: const IconThemeData(size: 20.0, color: colors.text),
    //     centerTitle: true,
    //     titleTextStyle: TextStyle(
    //       fontSize: 20.sp,
    //       color: colors.text,
    //       fontWeight: FontWeight.w600,
    //       fontFamily: 'Cairo',
    //     ),
    //   ),
    //   progressIndicatorTheme: const ProgressIndicatorThemeData(
    //     color: colors.primary,
    //   ),
    //   bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //     backgroundColor: colors.card,
    //     selectedItemColor: AppColors.secondary,
    //     unselectedItemColor: colors.textSubtle,
    //     selectedLabelStyle: TextStyle(
    //       fontSize: 12.sp,
    //       fontWeight: FontWeight.w600,
    //       color: AppColors.secondary,
    //     ),
    //     unselectedLabelStyle: TextStyle(
    //       fontSize: 12.sp,
    //       fontWeight: FontWeight.w600,
    //       color: colors.textSubtle,
    //     ),
    //   ),
    //   bottomSheetTheme: const BottomSheetThemeData(
    //     backgroundColor: colors.card,
    //     surfaceTintColor: Colors.transparent, // Prevents Material 3 tint
    //   ),
    //   dialogTheme: DialogThemeData(
    //     backgroundColor: colors.card,
    //     surfaceTintColor: colors.card,
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(AppRadius.bR15)),
    //   ),
    //   elevatedButtonTheme: ElevatedButtonThemeData(
    //       style: ElevatedButton.styleFrom(
    //     backgroundColor: colors.primary,
    //     foregroundColor: colors.textInverse,
    //     minimumSize: Size(323.w, 54.h),
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(AppRadius.bR8)),
    //   )),
    //   outlinedButtonTheme: OutlinedButtonThemeData(
    //       style: OutlinedButton.styleFrom(
    //     backgroundColor: colors.background,
    //     minimumSize: Size(323.w, 54.h),
    //     side: const BorderSide(color: colors.primary),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(AppRadius.bR8),
    //     ),
    //   )),
    //   inputDecorationTheme: InputDecorationTheme(
    //     filled: true,
    //     fillColor: colors.card,
    //     isDense: true,
    //     hintStyle: TextStyle(
    //       color: colors.textSubtle,
    //       fontSize: 12.sp,
    //       fontWeight: FontWeight.w400,
    //     ),
    //     contentPadding: EdgeInsets.symmetric(
    //       vertical: AppRadius.bR10,
    //       horizontal: AppSize.sW16,
    //     ),
    //     enabledBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(AppRadius.bR8),
    //       borderSide: const BorderSide(color: colors.border, width: 1),
    //     ),
    //     focusedBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(AppRadius.bR8),
    //       borderSide: const BorderSide(color: colors.primary, width: 1.5),
    //     ),
    //     errorBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(AppRadius.bR8),
    //       borderSide: const BorderSide(color: colors.error, width: 1),
    //     ),
    //     focusedErrorBorder: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(AppRadius.bR8),
    //       borderSide: const BorderSide(color: colors.error, width: 1.5),
    //     ),
    //   ),
    //   textTheme: _getTextTheme(colors),
    // );
  }

  // static TextTheme _getTextTheme(AppColorsExtension colors) {
  //   return TextTheme(
  //     headlineLarge: TextStyle(
  //       color: colors.primary,
  //       fontSize: AppRadius.bR24,
  //       fontWeight: FontWeight.w700,
  //     ),
  //     headlineMedium: TextStyle(
  //       color: colors.primary,
  //       fontSize: AppRadius.bR20,
  //       fontWeight: FontWeight.w700,
  //     ),
  //     headlineSmall: TextStyle(
  //       color: colors.primary,
  //       fontSize: AppRadius.bR18,
  //       fontWeight: FontWeight.w700,
  //     ),
  //     titleLarge: TextStyle(
  //       color: colors.text,
  //       fontSize: AppRadius.bR16,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     titleMedium: TextStyle(
  //       color: colors.text,
  //       fontSize: AppRadius.bR14,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     titleSmall: TextStyle(
  //       color: colors.text,
  //       fontSize: AppRadius.bR12,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     bodyLarge: TextStyle(
  //       color: colors.text,
  //       fontSize: AppRadius.bR10,
  //       fontWeight: FontWeight.w500,
  //     ),
  //     bodyMedium: TextStyle(
  //       color: colors.text,
  //       fontSize: AppRadius.bR16,
  //       fontWeight: FontWeight.w600,
  //     ),
  //     bodySmall: TextStyle(
  //       color: colors.text,
  //       fontSize: AppRadius.bR6,
  //       fontWeight: FontWeight.w600,
  //     ),
  //   );
  // }
}
