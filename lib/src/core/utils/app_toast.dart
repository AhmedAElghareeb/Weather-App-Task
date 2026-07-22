import 'package:base_structure/src/core/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  static OverlayEntry? _currentOverlay;

  static void showSuccess(
    String message, {
    BuildContext? context,
    int? duration,
  }) {
    _showTopNotice(
      message,
      context: context,
      duration: duration,
      backgroundColor: const Color(0xFFECFDF3),
      foregroundColor: const Color(0xFF12B76A),
      iconData: Icons.check_circle_outline_outlined,
    );
  }

  static void showError(
    String message, {
    BuildContext? context,
    int? duration,
  }) {
    _showTopNotice(
      message,
      context: context,
      duration: duration,
      backgroundColor: const Color(0xFFFDECEC),
      foregroundColor: const Color(0xFFB71212),
      iconData: Icons.error_outline_outlined,
    );
  }

  static void showWarning(
    String message, {
    BuildContext? context,
    int? duration,
  }) {
    _showTopNotice(
      message,
      context: context,
      duration: duration,
      backgroundColor: const Color(0xFFFFFCF5),
      foregroundColor: const Color(0xFFF79009),
      iconData: Icons.warning_amber_rounded,
    );
  }

  static void _showTopNotice(
    String message, {
    required Color backgroundColor,
    required Color foregroundColor,
    required IconData iconData,
    BuildContext? context,
    int? duration,
  }) {
    final targetContext = context ?? navigatorKey.currentContext;
    if (targetContext == null) return;

    final overlayState =
        Overlay.maybeOf(targetContext, rootOverlay: true) ??
        navigatorKey.currentState?.overlay;

    if (overlayState == null) {
      showSnackBar(
        message,
        backgroundColor: backgroundColor,
        textColor: foregroundColor,
        context: targetContext,
      );
      return;
    }

    _currentOverlay?.remove();

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _TopNoticeOverlay(
        message: message,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        iconData: iconData,
        duration: duration ?? 3,
        onDismissed: () {
          if (_currentOverlay == entry) {
            _currentOverlay = null;
          }
          entry.remove();
        },
      ),
    );

    _currentOverlay = entry;
    overlayState.insert(entry);
  }

  static void showSnackBar(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    BuildContext? context,
  }) {
    final snackBar = SnackBar(
      duration: const Duration(seconds: 3),
      content: Text(
        message,
        style: TextStyle(
          color: textColor ?? Colors.red,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: backgroundColor ?? Colors.white,
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: textColor ?? Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
    );
    ScaffoldMessenger.of(
      context ?? navigatorKey.currentContext!,
    ).showSnackBar(snackBar);
  }

  static void showSimpleToast({
    required String msg,
    Color? color,
    Color? textColor,
    ToastGravity? gravity,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      textColor: textColor ?? Colors.white,
      fontSize: 16.sp,
      backgroundColor: color ?? Colors.black,
    );
  }

  static void showErrorToast({required String msg, ToastGravity? gravity}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.sp,
      textColor: const Color(0xFFB71212),
      backgroundColor: const Color(0xFFFDECEC),
    );
  }

  static void showSuccessToast({required String msg, ToastGravity? gravity}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity ?? ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      fontSize: 16.sp,
      textColor: const Color(0xFF12B76A),
      backgroundColor: const Color(0xFFECFDF3),
    );
  }
}

class _TopNoticeOverlay extends StatefulWidget {
  const _TopNoticeOverlay({
    required this.message,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.iconData,
    required this.onDismissed,
    required this.duration,
  });

  final String message;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData iconData;
  final VoidCallback onDismissed;
  final int duration;

  @override
  State<_TopNoticeOverlay> createState() => _TopNoticeOverlayState();
}

class _TopNoticeOverlayState extends State<_TopNoticeOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 250),
    );
    _controller.forward();
    Future.delayed(Duration(seconds: widget.duration), _hide);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _hide() {
    if (!mounted) return;
    if (_controller.isDismissed ||
        _controller.status == AnimationStatus.reverse) {
      return;
    }

    _controller.reverse().whenComplete(() {
      widget.onDismissed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            if (details.primaryDelta! < -7) {
              _hide();
            }
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final offset =
                  Tween<Offset>(
                    begin: const Offset(0, -0.3),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Curves.easeOutBack,
                      reverseCurve: Curves.easeInCubic,
                    ),
                  );

              final opacity = CurvedAnimation(
                parent: _controller,
                curve: Curves.easeOut,
                reverseCurve: Curves.easeIn,
              );

              return SlideTransition(
                position: offset,
                child: FadeTransition(
                  opacity: opacity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    child: Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(12.r),
                      color: widget.backgroundColor,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 14.h,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              widget.iconData,
                              color: widget.foregroundColor,
                              size: 24.sp,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Text(
                                widget.message,
                                style: TextStyle(
                                  color: widget.foregroundColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
