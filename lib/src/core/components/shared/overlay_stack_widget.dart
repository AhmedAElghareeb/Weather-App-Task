import 'package:base_structure/src/core/utils/app_spaces.dart';
import 'package:flutter/material.dart';

class OverlayStackWidget extends StatelessWidget {
  const OverlayStackWidget({super.key, required this.overlayContentWidget});

  final Widget overlayContentWidget;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.6),
      child: SizedBox(
        height: AppSpaces.infinitySide,
        width: AppSpaces.infinitySide,
        child: Stack(
          alignment: Alignment.center,
          children: [overlayContentWidget],
        ),
      ),
    );
  }
}
