import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFieldWidget extends StatelessWidget {
  const AppTextFieldWidget({
    super.key,
    required this.controller,
    this.focusNode,
    this.title,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.borderColor,
    this.padding,
    this.alignLabelWithHint,
    this.filled,
    this.fillColor,
    this.enabled,
    this.textAlign,
    this.readOnly,
    this.raduis,
    this.validator,
    this.onTap,
    this.maxLines,
    this.style,
    this.textInputAction,
    this.keyboardType,
    this.obscureText,
    this.onSaved,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.autovalidateMode,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? title;
  final String? label;
  final String? hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String?>? onChanged;
  final Color? borderColor, fillColor;
  final EdgeInsets? padding;
  final bool? alignLabelWithHint;
  final bool? filled;
  final bool? enabled;
  final bool? readOnly;
  final TextAlign? textAlign;
  final double? raduis;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final int? maxLines;
  final TextStyle? style;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final ValueChanged<String?>? onSaved;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String?>? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          CustomText.titleLarge(
            title!,
            textAlign: TextAlign.start,
            textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        if (title != null) SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding:
                padding ??
                EdgeInsetsDirectional.symmetric(
                  horizontal: 10.w,
                  vertical: 10.h,
                ),
            alignLabelWithHint: alignLabelWithHint ?? true,
            errorMaxLines: 3,
            errorStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.red,
            ),
            border: border(context, borderColor: borderColor),
            focusedBorder: focusedBorder(context, borderColor: borderColor),
            errorBorder: errorBorder(context, borderColor: borderColor),
            disabledBorder: border(context, borderColor: borderColor),
            enabledBorder: border(context, borderColor: borderColor),
            focusedErrorBorder: errorBorder(context, borderColor: borderColor),
            fillColor: fillColor,
            filled: filled,
          ),
          onChanged: onChanged,
          textAlign: textAlign ?? TextAlign.start,
          enabled: enabled ?? true,
          readOnly: readOnly ?? false,
          validator: validator,
          onTap: onTap,
          maxLines: maxLines ?? 1,
          style:
              style ??
              Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
              ),
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          obscureText: obscureText ?? false,
          autovalidateMode: autovalidateMode,
        ),
      ],
    );
  }

  OutlineInputBorder border(
    BuildContext context, {
    required Color? borderColor,
  }) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(raduis ?? 10),
    borderSide: BorderSide(color: borderColor ?? AppColors.white),
  );

  OutlineInputBorder focusedBorder(
    BuildContext context, {
    required Color? borderColor,
  }) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(raduis ?? 10),
    borderSide: BorderSide(color: borderColor ?? AppColors.primary),
  );

  OutlineInputBorder errorBorder(
    BuildContext context, {
    required Color? borderColor,
  }) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(raduis ?? 10),
    borderSide: BorderSide(color: borderColor ?? AppColors.red),
  );
}
