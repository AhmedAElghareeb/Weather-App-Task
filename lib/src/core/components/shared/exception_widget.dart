import 'package:base_structure/src/core/components/assets_widgets/svg_image_widget.dart';
import 'package:base_structure/src/core/components/buttons/app_button.dart';
import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:base_structure/src/core/extensions/assets_extension.dart';
import 'package:base_structure/src/core/utils/app_spaces.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({super.key, required this.error, this.onClick});

  final String error;
  final Future<void> Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgImageWidget(image: 'exception.svg'.addIconAsset(), side: 100.sp),
          AppSpaces.verticalSpace3,
          Padding(
            padding: AppSpaces.horizontalPadding4,
            child: CustomText.bodyLarge(
              error,
              textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.red,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          if (onClick != null) AppSpaces.verticalSpace3,
          if (onClick != null)
            Padding(
              padding: AppSpaces.horizontalPadding4,
              child: AppButton<Future<void>>(
                onPressed: () async => onClick?.call(),
                title: 'retry'.tr(),
              ),
            ),
        ],
      ),
    );
  }
}
