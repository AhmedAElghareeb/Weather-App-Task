import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LayoutExpansionTileWidget extends StatefulWidget {
  const LayoutExpansionTileWidget({
    super.key,
    required this.title,
    required this.children,
    this.titleWidget,
    this.initiallyExpanded = false,
    this.trailing,
    this.padding,
    this.titleStyle,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.borderRadius,
    this.onExpansionChanged,
  });

  final String title;
  final List<Widget> children;
  final Widget? titleWidget;
  final bool initiallyExpanded;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final double? borderRadius;
  final ValueChanged<bool>? onExpansionChanged;

  @override
  State<LayoutExpansionTileWidget> createState() =>
      _LayoutExpansionTileWidgetState();
}

class _LayoutExpansionTileWidgetState extends State<LayoutExpansionTileWidget> {
  late ExpansibleController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ExpansibleController();
  }

  @override
  void didUpdateWidget(covariant LayoutExpansionTileWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initiallyExpanded != oldWidget.initiallyExpanded) {
      if (widget.initiallyExpanded) {
        _controller.expand();
      } else {
        _controller.collapse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(widget.borderRadius ?? 8.r);

    return Container(
      decoration: BoxDecoration(
        color: widget.collapsedBackgroundColor ?? AppColors.grey,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          controller: _controller,
          title:
              widget.titleWidget ??
              Text(
                widget.title,
                style:
                    widget.titleStyle ??
                    TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
          initiallyExpanded: widget.initiallyExpanded,
          onExpansionChanged: widget.onExpansionChanged,
          trailing: widget.trailing,
          childrenPadding:
              widget.padding ??
              EdgeInsets.only(left: 12.w, right: 12.w, bottom: 12.h),
          backgroundColor: widget.backgroundColor ?? AppColors.grey,
          collapsedBackgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: radius),
          collapsedShape: RoundedRectangleBorder(borderRadius: radius),
          children: widget.children,
        ),
      ),
    );
  }
}
