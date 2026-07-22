import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.child,
    this.backgroundColor,
    this.height,
    this.width,
    this.hasElevation = true,
    this.radius,
    this.onClick,
    this.padding,
    this.margin,
    this.borderColor,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding, margin;
  final double? height, width, radius;
  final VoidCallback? onClick;
  final bool hasElevation;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.white,
          borderRadius: BorderRadius.circular(radius ?? 8),
          boxShadow: [
            if (hasElevation)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 1.8,
                offset: const Offset(0, 0),
              ),
          ],
          border: borderColor != null ? Border.all(color: borderColor!) : null,
        ),
        padding: padding,
        margin: margin,
        child: Center(child: child),
      ),
    );
  }
}
