import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownSearchWidget<T> extends StatefulWidget {
  const DropdownSearchWidget({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.itemAsString,
    required this.onChanged,
    required this.selectedValue,
    required this.validator,
  });

  final String hint;
  final String label;
  final List<T> items;
  final String Function(T)? itemAsString;
  final Function(T?) onChanged;
  final T? selectedValue;
  final String? Function(T?)? validator;

  @override
  State<DropdownSearchWidget<T>> createState() =>
      _DropdownSearchWidgetState<T>();
}

class _DropdownSearchWidgetState<T> extends State<DropdownSearchWidget<T>> {
  late T? _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedValue;
  }

  @override
  void didUpdateWidget(covariant DropdownSearchWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != oldWidget.selectedValue) {
      setState(() {
        _selectedItem = widget.selectedValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText.titleLarge(
          widget.label,
          textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownSearch<T>(
          compareFn: (i, s) => i == s,
          popupProps: PopupProps.menu(
            showSearchBox: true,
            menuProps: const MenuProps(backgroundColor: Colors.white),
            searchDelay: const Duration(milliseconds: 500),
            itemBuilder: (context, item, isDisabled, _) {
              final isSelected = _selectedItem == item;
              return Container(
                color: isSelected
                    ? AppColors.grey.withValues(alpha: 0.1)
                    : null,
                child: ListTile(
                  selected: isSelected,
                  title: CustomText.bodyMedium(
                    widget.itemAsString != null
                        ? widget.itemAsString!(item)
                        : item.toString(),
                    textAlign: TextAlign.start,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected ? AppColors.black : AppColors.grey,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
            searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                fillColor: AppColors.white,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 15.w,
                ),
                prefixIcon: Icon(CupertinoIcons.search, color: AppColors.black),
                alignLabelWithHint: true,
                hintText: 'search'.tr(),
                border: _border(context),
                enabledBorder: _border(context),
                focusedBorder: _border(context),
                errorBorder: _border(context),
                focusedErrorBorder: _border(context),
                disabledBorder: _border(context),
              ),
            ),
          ),
          selectedItem: _selectedItem,
          items: (f, p) => widget.items,
          itemAsString: widget.itemAsString,
          validator: widget.validator,
          decoratorProps: DropDownDecoratorProps(
            baseStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 18.h,
                horizontal: 10.w,
              ),
              filled: true,
              fillColor: AppColors.white,
              hintText: widget.hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.grey,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: AppColors.red,
                fontSize: 12.sp,
              ),
              errorMaxLines: 3,
              alignLabelWithHint: true,
              border: _border(context),
              enabledBorder: _border(context),
              focusedBorder: _border(context),
              errorBorder: _border(context),
              focusedErrorBorder: _border(context),
              disabledBorder: _border(context),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _selectedItem = value;
            });
            widget.onChanged(value);
          },
          suffixProps: DropdownSuffixProps(
            dropdownButtonProps: DropdownButtonProps(
              iconOpened: Icon(
                Icons.keyboard_arrow_up_outlined,
                size: 24.sp,
                color: AppColors.grey,
              ),
              iconClosed: Icon(
                Icons.keyboard_arrow_down_outlined,
                size: 24.sp,
                color: AppColors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _border(context) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.grey),
  );
}
