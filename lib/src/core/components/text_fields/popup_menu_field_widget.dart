import 'package:base_structure/src/core/components/buttons/popup_menu_button_widget.dart';
import 'package:base_structure/src/core/components/text_fields/app_text_field_widget.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopupMenuFieldWidget<T> extends StatelessWidget {
  const PopupMenuFieldWidget({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    required this.itemValue,
    required this.hint,
    required this.controller,
    this.title,
    this.label,
    this.itemSubvalue,
    this.focusNode,
    this.validator,
    this.readOnly,
    this.enabled,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
  });

  final List<T> items;
  final T? selectedItem;
  final Function(T)? onSelected;
  final String Function(T) itemValue;
  final String Function(T)? itemSubvalue;
  final String? title;
  final String? label;
  final String hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool? readOnly;
  final double? borderRadius;
  final Color? fillColor, borderColor;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButtonWidget(
      items: items,
      selectedItem: selectedItem,
      onSelected: onSelected,
      itemValue: itemValue,
      itemSubvalue: itemSubvalue,
      child: AppTextFieldWidget(
        // title: label,
        // label: label,
        hint: hint,
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly ?? false,
        enabled: enabled ?? true,
        fillColor: fillColor,
        borderColor: borderColor,
        suffixIcon: Padding(
          padding: const EdgeInsetsDirectional.only(end: 8.0),
          child: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 24.sp,
            color: AppColors.grey,
          ),
        ),
        validator: validator,
      ),
    );
  }
}
