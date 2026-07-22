import 'package:base_structure/src/core/components/shared/overlay_stack_widget.dart';
import 'package:flutter/material.dart';

abstract class OverlayHelper {
  static void onShowOverlay(
    BuildContext context, {
    required Widget overlayContentWidget,
  }) => showGeneralDialog(
    context: context,
    barrierDismissible: false,
    pageBuilder: (_, __, ___) =>
        OverlayStackWidget(overlayContentWidget: overlayContentWidget),
  );
}
