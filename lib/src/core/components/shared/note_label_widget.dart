import 'package:base_structure/src/core/components/shared/note_icon_widget.dart';
import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:base_structure/src/core/extensions/assets_extension.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteLabelWidget extends StatelessWidget {
  const NoteLabelWidget({super.key, required this.message, this.icon});

  final String message;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NoteIconWidget(icon: icon ?? 'exception.svg'.addIconAsset()),
        8.horizontalSpace,
        Flexible(
          child: CustomText.titleLarge(
            message,
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
