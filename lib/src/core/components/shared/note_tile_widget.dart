import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:base_structure/src/core/utils/app_spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteTileWidget extends StatelessWidget {
  const NoteTileWidget({
    super.key,
    required this.description,
    this.maxLines = 4,
    this.overflow,
  });

  final String description;
  final int maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.titleLarge(
          "•",
          textAlign: TextAlign.start,
          textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpaces.horizontalSpace1,
        Expanded(
          child: CustomText.titleLarge(
            description,
            textAlign: TextAlign.start,
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
            maxLines: maxLines,
            overflow: overflow,
          ),
        ),
      ],
    );
  }
}
