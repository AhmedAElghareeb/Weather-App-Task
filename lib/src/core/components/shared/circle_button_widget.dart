import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';

class CircleButtonWidget extends StatelessWidget {
  const CircleButtonWidget({
    super.key,
    required this.side,
    required this.onClick,
    this.color,
    this.decoratedImage,
    this.child,
    this.padding,
    this.margin,
    this.borderColor,
    this.shadow = true,
    this.isInk = false,
  });

  final double side;
  final VoidCallback onClick;
  final Color? color;
  final DecorationImage? decoratedImage;
  final Widget? child;
  final EdgeInsetsGeometry? padding, margin;
  final Color? borderColor;
  final bool shadow, isInk;

  @override
  Widget build(BuildContext context) {
    return (isInk == true)
        ? GestureDetector(
            onTap: onClick,
            child: Container(
              padding: padding ?? const EdgeInsets.all(2),
              margin: margin,
              height: side,
              width: side,
              decoration: BoxDecoration(
                color: color,
                image: decoratedImage,
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor ?? AppColors.transparent,
                  width: .8,
                ),
                boxShadow: shadow == true
                    ? const [
                        BoxShadow(
                          offset: Offset(0.5, 0.5),
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: Center(child: child ?? const SizedBox()),
            ),
          )
        : InkWell(
            onTap: onClick,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: padding ?? const EdgeInsets.all(2),
              margin: margin,
              height: side,
              width: side,
              decoration: BoxDecoration(
                color: color,
                image: decoratedImage,
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor ?? AppColors.transparent,
                  width: .8,
                ),
                boxShadow: shadow == true
                    ? const [
                        BoxShadow(
                          offset: Offset(0.5, 0.5),
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 1,
                        ),
                      ]
                    : null,
              ),
              child: Center(child: child ?? const SizedBox()),
            ),
          );
  }
}
