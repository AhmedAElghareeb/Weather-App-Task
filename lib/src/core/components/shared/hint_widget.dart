import 'package:base_structure/src/core/components/assets_widgets/svg_image_widget.dart';
import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HintWidget extends StatelessWidget {
  const HintWidget({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.titleColor,
    required this.descriptionColor,
    required this.assetPath,
    required this.title,
    required this.description,
    this.maxLines,
    this.hasShadow = false,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Color titleColor;
  final Color descriptionColor;
  final String assetPath;
  final String title;
  final String description;
  final int? maxLines;
  final bool hasShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16.r),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 5,
                  offset: const Offset(4, 7),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgImageWidget(image: assetPath, width: 18.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: CustomText.titleLarge(
                  title,
                  textAlign: TextAlign.start,
                  textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                    height: 1.4,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          CustomText.titleLarge(
            description,
            textAlign: TextAlign.start,
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: descriptionColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            maxLines: maxLines ?? 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
