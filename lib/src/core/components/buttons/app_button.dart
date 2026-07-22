import 'package:async_button_handler/async_button_handler.dart';
import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum IconDirection { left, right }

class AppButton<T> extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.loadingWidget,
    this.backgroundColor,
    this.shadowColor,
    this.elevation,
    this.borderColor,
    this.borderWidth,
    this.borderRadius = 10,
    this.padding,
    this.contentPadding,
    this.minimumSize,
    this.fixedSize,
    this.tapTargetSize,
    this.style,
    this.fontColor,
    this.fontSize,
    this.fontWeight,
    this.fontFamily,
    this.decoration,
    this.height,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.space = 4,
    this.iconDirection = IconDirection.right,
  });

  final T Function() onPressed;
  final Widget? loadingWidget;
  final Color? backgroundColor, shadowColor;
  final double? elevation;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final Size? minimumSize;
  final Size? fixedSize;
  final MaterialTapTargetSize? tapTargetSize;
  final String title;
  final TextStyle? style;
  final Color? fontColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;
  final String? fontFamily;
  final double? height;
  final Color? iconColor;
  final double? iconSize;
  final double space;
  final Object? icon;
  final IconDirection iconDirection;

  @override
  Widget build(BuildContext context) {
    return AsyncButtonHandler(
      onPressed: onPressed,
      style: ButtonStyle(
        tapTargetSize: tapTargetSize,
        minimumSize: minimumSize != null && fixedSize == null
            ? WidgetStateProperty.all<Size>(minimumSize!)
            : minimumSize == null && fixedSize == null
            ? WidgetStateProperty.all<Size>(Size(double.infinity, 52.h))
            : null,
        fixedSize: fixedSize != null && minimumSize == null
            ? WidgetStateProperty.all<Size>(fixedSize!)
            : minimumSize == null && fixedSize == null
            ? WidgetStateProperty.all<Size>(Size(double.infinity, 52.h))
            : null,
        elevation: WidgetStateProperty.all<double?>(elevation ?? 0),
        shadowColor: WidgetStateProperty.all<Color>(
          shadowColor ?? Colors.transparent,
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          backgroundColor ?? Theme.of(context).primaryColor,
        ),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            side: BorderSide(
              color:
                  borderColor ??
                  backgroundColor ??
                  Theme.of(context).primaryColor,
              width: borderWidth ?? 1,
            ),
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
          ),
        ),
        padding: WidgetStatePropertyAll(padding ?? EdgeInsets.zero),
      ),
      loadingChild:
          loadingWidget ??
          SizedBox(
            height: 32,
            width: 32,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                fontColor ?? Colors.white,
              ),
              strokeWidth: 1.5,
            ),
          ),
      widget: Padding(
        padding: contentPadding ?? EdgeInsets.zero,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconDirection == IconDirection.left && icon != null)
              _buildIcon(icon!, iconSize, iconColor),
            if (iconDirection == IconDirection.left && icon != null)
              SizedBox(width: space),
            if (title.isNotEmpty)
              CustomText.titleLarge(
                title,
                textStyle:
                    style ??
                    Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: fontColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                      decoration: decoration,
                      fontFamily: fontFamily,
                      height: height,
                    ),
              ),
            if (iconDirection == IconDirection.right && icon != null)
              SizedBox(width: space),
            if (iconDirection == IconDirection.right && icon != null)
              _buildIcon(icon!, iconSize, iconColor),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(Object icon, double? iconSize, Color? iconColor) {
    return (icon.runtimeType == String)
        ? SvgPicture.asset(
            icon as String,
            height: iconSize ?? 20,
            width: iconSize ?? 20,
            colorFilter: iconColor != null
                ? ColorFilter.mode(iconColor, BlendMode.srcIn)
                : null,
          )
        : Icon(icon as IconData, size: iconSize ?? 20, color: iconColor);
  }
}
