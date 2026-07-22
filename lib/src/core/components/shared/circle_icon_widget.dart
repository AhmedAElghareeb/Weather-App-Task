import 'package:flutter/material.dart';

class CircleIconWidget extends StatelessWidget {
  const CircleIconWidget({
    super.key,
    this.height = 18,
    this.width = 18,
    this.color = Colors.blue,
    required this.icon,
    this.iconColor = Colors.white,
    this.iconSize = 12,
    this.onTap,
  });

  final double height, width;
  final Color color;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        child: Icon(icon, color: iconColor, size: iconSize),
      ),
    );
  }
}
