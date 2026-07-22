import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryTileWidget extends StatelessWidget {
  const SummaryTileWidget({
    super.key,
    required this.title,
    required this.value,
    this.flex1 = 2,
    this.flex2 = 3,
    this.textDirection,
  });

  final String title, value;
  final int flex1, flex2;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: flex1,
          child: CustomText.titleLarge(
            title,
            textAlign: TextAlign.start,
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: flex2,
          child: CustomText.titleLarge(
            value,
            textAlign: TextAlign.end,
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            textDirection: textDirection,
          ),
        ),
      ],
    );
  }
}
