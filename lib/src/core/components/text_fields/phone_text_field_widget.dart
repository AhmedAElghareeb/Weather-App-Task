import 'dart:ui' as ui;

import 'package:base_structure/src/core/components/text_fields/app_text_field_widget.dart';
import 'package:base_structure/src/core/helpers/validation_helper.dart';
import 'package:base_structure/src/core/language/language_helper/language_manager.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneTextFieldWidget extends StatelessWidget {
  const PhoneTextFieldWidget({
    super.key,
    required this.controller,
    this.onSelected,
    this.initialSelection,
    this.focusNode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final void Function(CountryCode)? onSelected;
  final String? initialSelection;

  @override
  Widget build(BuildContext context) {
    return AppTextFieldWidget(
      // title: 'textFieldData.phone'.tr(),
      // label: 'textFieldData.phone'.tr(),
      hint: 'textFieldData.phone'.tr(),
      controller: controller,
      focusNode: focusNode,
      borderColor: AppColors.black.withValues(alpha: 0.05),
      keyboardType: TextInputType.phone,
      validator: Validators.validatePhone,
      prefixIcon: Container(
        height: 56.h,
        margin: EdgeInsetsDirectional.only(end: 10.w),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          border: BorderDirectional(
            end: BorderSide(color: AppColors.black.withValues(alpha: 0.05)),
          ),
          borderRadius: const BorderRadiusDirectional.only(
            topStart: Radius.circular(10),
            bottomStart: Radius.circular(10),
          ),
        ),
        child: Directionality(
          textDirection: ui.TextDirection.ltr,
          child: CountryCodePicker(
            onChanged: onSelected,
            initialSelection: initialSelection ?? 'EG',
            favorite: const ['+20', 'EG'],
            showCountryOnly: false,
            showOnlyCountryWhenClosed: false,
            alignLeft: false,
            showFlag: true,
            showFlagDialog: true,
            padding: EdgeInsets.zero,
            flagWidth: 24.sp,
            flagDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
            ),
            dialogTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
              height: 1.5,
              locale: (LanguageManager.currentLang == 'ar')
                  ? const Locale('ar')
                  : const Locale('en'),
            ),
            headerText: 'choose'.tr(),
            headerTextStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.black,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: AppColors.black,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              letterSpacing: 0,
              height: 1.5,
            ),
            searchDecoration: InputDecoration(
              prefixIcon: Padding(
                padding: EdgeInsetsDirectional.only(start: 5.w, end: 5.w),
                child: Icon(
                  CupertinoIcons.search,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
              contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 10.h),
              hintText: 'search'.tr(),
              hintStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.black,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              border: _border(),
              enabledBorder: _border(),
              focusedBorder: _border(),
              errorBorder: _border(),
              focusedErrorBorder: _border(),
              disabledBorder: _border(),
            ),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: AppColors.black.withValues(alpha: 0.05)),
    );
  }
}
