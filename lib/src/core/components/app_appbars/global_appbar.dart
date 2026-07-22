import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? iconColor;
  final bool showBackButton;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final double? elevation;
  final TextStyle? titleStyle;
  final double? height;

  const GlobalAppbar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.backgroundColor,
    this.titleColor,
    this.iconColor,
    this.showBackButton = true,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.elevation,
    this.titleStyle,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.white,
      elevation: elevation ?? 0,
      centerTitle: centerTitle,
      leading: leading ?? _buildLeading(context),
      actions: actions,
      automaticallyImplyLeading: showBackButton,
      title: CustomText.headlineMedium(
        title,
        textStyle: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: titleColor ?? AppColors.black,
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (!showBackButton) return null;

    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: iconColor ?? AppColors.black,
        size: 20.sp,
      ),
      onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? 56.h);
}
