import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LinearPercentIndicatorWidget extends StatelessWidget {
  const LinearPercentIndicatorWidget({
    super.key,
    required this.percent,
    this.lineHeight,
    this.width,
    this.padding,
    this.activeColor,
    this.inactiveColor,
    this.animationDuration,
  });

  final double percent;
  final double? lineHeight, width;
  final EdgeInsets? padding;
  final Color? activeColor, inactiveColor;
  final int? animationDuration;

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      padding: padding ?? EdgeInsets.zero,
      animation: true,
      lineHeight: lineHeight ?? 10,
      animationDuration: animationDuration ?? 2000,
      percent: percent,
      barRadius: const Radius.circular(5),
      progressColor: activeColor ?? Colors.greenAccent,
      backgroundColor: inactiveColor ?? Colors.red,
    );
  }
}
