import 'package:base_structure/src/core/utils/app_spaces.dart';
import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({
    super.key,
    this.height,
    this.width,
    this.color,
    this.margin,
  });

  final double? height, width;
  final Color? color;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      height: height ?? 1.2,
      width: width ?? AppSpaces.infinitySide,
      color: color ?? Colors.grey,
    );
  }
}
