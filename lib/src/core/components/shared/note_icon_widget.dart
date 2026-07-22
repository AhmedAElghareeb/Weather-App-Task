import 'package:base_structure/src/core/components/assets_widgets/svg_image_widget.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteIconWidget extends StatelessWidget {
  const NoteIconWidget({super.key, required this.icon});

  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32.sp,
      width: 32.sp,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SvgImageWidget(image: icon, side: 16.sp),
    );
  }
}
