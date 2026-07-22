import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PopupMenuButtonWidget<T> extends StatelessWidget {
  const PopupMenuButtonWidget({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    required this.itemValue,
    required this.child,
    this.itemSubvalue,
    this.radius,
    this.borderColor,
  });

  final List<T> items;
  final T? selectedItem;
  final Function(T)? onSelected;
  final String Function(T) itemValue;
  final String Function(T)? itemSubvalue;
  final Widget child;
  final double? radius;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 8.0),
        side: BorderSide(
          color: borderColor ?? AppColors.transparent,
          width: 1.5,
        ),
      ),
      color: AppColors.white,
      initialValue: selectedItem,
      itemBuilder: (_) => List.generate(items.length, (index) {
        return PopupMenuItem(
          value: items[index],
          textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
          ),
          child: RichText(
            text: TextSpan(
              text: itemValue(items[index]),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
              ),
              children: [
                if (itemSubvalue != null)
                  TextSpan(
                    text:
                        '  ${itemSubvalue!(items[index]) != '' ? '(${itemSubvalue!(items[index])})' : ''}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 10.sp,
                    ),
                  ),
              ],
            ),
          ),
        );
      }),
      onSelected: onSelected,
      child: child,
    );
  }
}
