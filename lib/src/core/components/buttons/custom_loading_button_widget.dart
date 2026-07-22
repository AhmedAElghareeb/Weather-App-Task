import 'dart:ui' show lerpDouble;

import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum ButtonStatus { loading, idle }

class CustomAnimatedButton extends StatefulWidget {
  final double height;
  final double width;
  final double minWidth;
  final Widget? loader;
  final Duration animationDuration;
  final Curve curve;
  final Curve reverseCurve;
  final Widget child;
  final Future<void> Function() onTap;
  final Color? color;
  final Brightness? colorBrightness;
  final double? elevation;
  final EdgeInsetsGeometry padding;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool roundLoadingShape;
  final double borderRadius;
  final BorderSide borderSide;
  final double? disabledElevation;
  final Color? disabledColor;
  final Color? disabledTextColor;

  const CustomAnimatedButton({
    required this.height,
    required this.width,
    this.minWidth = 0,
    this.loader,
    this.animationDuration = const Duration(milliseconds: 500),
    this.curve = Curves.easeInOutCirc,
    this.reverseCurve = Curves.easeInOutCirc,
    required this.child,
    required this.onTap,
    this.color,
    this.colorBrightness,
    this.elevation,
    this.padding = const EdgeInsets.all(0),
    this.borderRadius = 0.0,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.materialTapTargetSize,
    this.roundLoadingShape = true,
    this.borderSide = BorderSide.none,
    this.disabledElevation,
    this.disabledColor,
    this.disabledTextColor,
    super.key,
  }) : assert(elevation == null || elevation >= 0.0),
       assert(disabledElevation == null || disabledElevation >= 0.0);

  @override
  CustomButtonState createState() => CustomButtonState();
}

class CustomButtonState extends State<CustomAnimatedButton>
    with TickerProviderStateMixin {
  double? loaderWidth;

  late Animation<double> _animation;
  late AnimationController _controller;
  ButtonStatus buttonStatus = ButtonStatus.idle;

  double _minWidth = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve,
      ),
    );

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if (!mounted) return;
        setState(() {
          buttonStatus = ButtonStatus.idle;
        });
      }
    });

    minWidth = widget.height;
    loaderWidth = widget.height;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startLoading() {
    if (!mounted) return;
    setState(() {
      buttonStatus = ButtonStatus.loading;
    });
    _controller.forward();
  }

  void stopLoading() {
    if (!mounted) return;
    _controller.reverse();
  }

  lerpWidth(a, b, t) {
    if (a == 0.0 || b == 0.0) {
      return null;
    } else {
      return a + (b - a) * t;
    }
  }

  double get minWidth => _minWidth;

  set minWidth(double w) {
    if (widget.minWidth == 0) {
      _minWidth = w;
    } else {
      _minWidth = widget.minWidth;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return _buildButton();
      },
    );
  }

  void doWhileLoading() async {
    try {
      startLoading();
      await widget.onTap();
    } finally {
      stopLoading();
    }
  }

  Widget _buildButton() {
    return SizedBox(
      height: widget.height,
      width: lerpWidth(widget.width, minWidth, _animation.value),
      child: ButtonTheme(
        height: widget.height,
        shape: RoundedRectangleBorder(
          side: widget.borderSide,

          borderRadius: BorderRadius.circular(
            widget.roundLoadingShape
                ? lerpDouble(
                    widget.borderRadius,
                    widget.height / 2,
                    _animation.value,
                  )!
                : widget.borderRadius,
          ),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            elevation: widget.elevation,
            shadowColor: Colors.transparent,
            padding: widget.padding,
            disabledBackgroundColor: widget.disabledColor,
            shape: RoundedRectangleBorder(
              side: widget.borderSide,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
          clipBehavior: widget.clipBehavior,
          focusNode: widget.focusNode,
          onPressed: buttonStatus == ButtonStatus.idle
              ? () {
                  doWhileLoading();
                }
              : null,
          child: buttonStatus == ButtonStatus.idle
              ? widget.child
              : widget.loader,
        ),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  final String title;
  final Future<void> Function() onTap;
  final Color? textColor;
  final Color? color;
  final BorderSide borderSide;
  final double? borderRadius;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Widget? customChild;
  final Widget? customLoading;
  final bool customLoader;

  const LoadingButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.textColor,
    this.borderRadius,
    this.margin,
    this.borderSide = BorderSide.none,
    this.fontFamily,
    this.fontSize,
    this.width,
    this.height,
    this.fontWeight,
    this.customChild,
    this.customLoading,
    this.customLoader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: CustomAnimatedButton(
        onTap: onTap,
        width: width ?? MediaQuery.sizeOf(context).width,
        minWidth: 50.w,
        height: height ?? 52.h,
        color: color ?? AppColors.primary,
        borderRadius: borderRadius ?? 10.r,
        disabledColor: color ?? AppColors.grey,
        borderSide: borderSide,
        loader: customLoader
            ? customLoading
            : SpinKitDoubleBounce(color: AppColors.white, size: 52.h),
        child:
            customChild ??
            CustomText.titleLarge(
              title,
              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: textColor ?? AppColors.white,
                fontWeight: fontWeight ?? FontWeight.w500,
                fontSize: fontSize ?? 16.sp,
              ),
            ),
      ),
    );
  }
}
