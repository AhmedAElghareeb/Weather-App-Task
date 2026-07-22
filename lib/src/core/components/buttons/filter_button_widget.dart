import 'package:base_structure/src/core/components/shared/card_widget.dart';
import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:base_structure/src/core/utils/app_spaces.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({
    super.key,
    required this.isActive,
    required this.title,
    this.onClick,
    this.icon,
    this.backgroundColor,
    this.iconColor,
    this.iconSize,
    this.isSpacing = false,
  });

  final bool isActive;
  final String title;
  final VoidCallback? onClick;
  final IconData? icon;
  final Color? backgroundColor, iconColor;
  final double? iconSize;
  final bool isSpacing;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      height: 44.h,
      width: AppSpaces.infinitySide,
      padding: isSpacing ? AppSpaces.horizontalPadding3 : null,
      radius: 6,
      backgroundColor: backgroundColor ?? AppColors.white,
      onClick: onClick,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText.titleLarge(
            title,
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 11.sp,
              height: 2,
              color: isActive ? iconColor ?? AppColors.grey : AppColors.black,
              overflow: TextOverflow.ellipsis,
            ),
            maxLines: 1,
          ),
          if (icon != null) AppSpaces.horizontalSpace1,
          if (isSpacing) const Spacer(),
          Icon(
            icon ?? Icons.arrow_drop_down_outlined,
            color: isActive
                ? iconColor ?? AppColors.grey.withValues(alpha: .8)
                : AppColors.grey,
            size: iconSize ?? 22.sp,
          ),
        ],
      ),
    );
  }
}
