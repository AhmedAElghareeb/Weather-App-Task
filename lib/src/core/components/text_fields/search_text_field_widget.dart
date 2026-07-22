import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchInputFieldWidget extends StatelessWidget {
  const SearchInputFieldWidget({
    super.key,
    required this.isActive,
    required this.controller,
    required this.focusNode,
    this.hint,
    this.keyboardType,
    this.onChanged,
    this.onSubmitted,
  });

  final bool isActive;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? hint;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 45.h,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          readOnly: !isActive,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          keyboardType: keyboardType ?? TextInputType.text,
          cursorColor: AppColors.primary,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintText: hint ?? 'search'.tr(),
            hintStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 14.sp,
              color: isActive
                  ? AppColors.grey.withValues(alpha: .8)
                  : AppColors.grey,
            ),
            errorStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: AppColors.red,
              fontSize: 12.sp,
            ),
            errorMaxLines: 2,
            prefixIcon: Padding(
              padding: EdgeInsetsDirectional.only(start: 10.w, end: 5.w),
              child: Icon(
                CupertinoIcons.search,
                color: isActive
                    ? AppColors.grey.withValues(alpha: .8)
                    : AppColors.grey,
                size: 18.sp,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            suffixIconConstraints: const BoxConstraints(),
            prefixIconConstraints: const BoxConstraints(),
            border: _border(context),
            enabledBorder: _border(context),
            focusedBorder: _border(context),
            errorBorder: _border(context),
            focusedErrorBorder: _border(context),
            disabledBorder: _border(context),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _border(context) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.black),
  );
}
