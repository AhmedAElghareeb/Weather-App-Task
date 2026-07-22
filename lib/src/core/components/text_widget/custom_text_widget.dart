import 'package:base_structure/src/core/navigation/app_router.dart';
import 'package:flutter/material.dart';

/// Custom text widget with theme-aware styling
class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    required this.textStyle,
    this.textAlign,
    this.textDirection,
    this.overflow,
    this.maxLines,
    this.textScaler = const TextScaler.linear(1.0),
    this.fontFamily,
  });

  CustomText.headlineLarge(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.headlineLarge,
         fontFamily: fontFamily,
       );

  CustomText.headlineMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.headlineMedium,
         fontFamily: fontFamily,
       );

  CustomText.headlineSmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.headlineSmall,
         fontFamily: fontFamily,
       );

  CustomText.titleLarge(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextDirection? textDirection,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textDirection: textDirection,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.titleLarge,
         fontFamily: fontFamily,
       );

  CustomText.titleMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
    TextDirection? textDirection,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textDirection: textDirection,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.titleMedium,
         fontFamily: fontFamily,
       );

  CustomText.titleSmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.titleSmall,
         fontFamily: fontFamily,
       );

  CustomText.bodySmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.bodySmall,
         fontFamily: fontFamily,
       );

  CustomText.bodyMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.bodyMedium,
         fontFamily: fontFamily,
       );

  CustomText.bodyLarge(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.bodyLarge,
         fontFamily: fontFamily,
       );

  CustomText.labelSmall(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.labelSmall,
         fontFamily: fontFamily,
       );

  CustomText.labelMedium(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.labelMedium,
         fontFamily: fontFamily,
       );

  CustomText.labelLarge(
    String text, {
    Key? key,
    TextAlign? textAlign,
    String? fontFamily,
    int? maxLines,
    TextStyle? textStyle,
    TextOverflow? overflow,
    TextScaler? textScaler,
  }) : this(
         text,
         key: key,
         maxLines: maxLines,
         textAlign: textAlign,
         overflow: overflow,
         textScaler: textScaler ?? const TextScaler.linear(1.0),
         textStyle:
             textStyle ??
             Theme.of(navigatorKey.currentContext!).textTheme.labelLarge,
         fontFamily: fontFamily,
       );

  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextScaler? textScaler;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle ?? Theme.of(context).textTheme.titleMedium,
      textAlign: textAlign ?? TextAlign.center,
      textDirection: textDirection,
      overflow: overflow,
      maxLines: maxLines,
      textScaler: textScaler,
    );
  }
}
