import 'package:base_structure/src/core/components/buttons/filter_button_widget.dart';
import 'package:base_structure/src/core/components/buttons/popup_menu_button_widget.dart';
import 'package:flutter/material.dart';

class FilterOptionDdlWidget<T> extends StatelessWidget {
  const FilterOptionDdlWidget({
    super.key,
    required this.items,
    required this.onSelected,
    required this.itemToString,
    required this.selectedItem,
    required this.title,
    this.backgroundColor,
    this.iconColor,
    required this.isActive,
    this.isSpacing = false,
  });

  final List<T> items;
  final T? selectedItem;
  final ValueChanged<T> onSelected;
  final String Function(T) itemToString;
  final String title;
  final Color? backgroundColor, iconColor;
  final bool isActive;
  final bool isSpacing;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButtonWidget(
      items: items,
      selectedItem: selectedItem,
      onSelected: onSelected,
      itemValue: itemToString,
      child: FilterButtonWidget(
        isActive: isActive,
        isSpacing: isSpacing,
        title: title,
        backgroundColor: backgroundColor,
        iconColor: iconColor,
      ),
    );
  }
}
