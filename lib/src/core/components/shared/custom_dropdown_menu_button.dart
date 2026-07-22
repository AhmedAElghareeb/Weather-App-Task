import 'package:base_structure/src/core/components/text_fields/app_text_field_widget.dart';
import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDownMenuButton<T> extends StatefulWidget {
  const CustomDropDownMenuButton({
    super.key,
    this.hint,
    this.value,
    required this.items,
    this.isString = true,
    this.getItemText,
    this.onChanged,
    this.validator,
    this.isHasValidator = true,
    this.enabled = true,
    this.hasPagination = false,
    this.onLoadMore,
    this.hasMoreData = false,
    this.initialPage = 1,
  });

  final String? hint;
  final T? value;
  final List<T> items;
  final bool isString;
  final String Function(T)? getItemText;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final bool isHasValidator;
  final bool enabled;

  /// for pagination
  final bool hasPagination;
  final Future<List<T>> Function(int page, String searchQuery)? onLoadMore;
  final bool hasMoreData;
  final int initialPage;

  @override
  State<CustomDropDownMenuButton<T>> createState() =>
      _CustomDropDownMenuButton<T>();
}

class _CustomDropDownMenuButton<T> extends State<CustomDropDownMenuButton<T>> {
  T? selectedValue;
  final searchController = TextEditingController();
  final scrollController = ScrollController();

  List<T> filteredItems = [];

  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMore = false;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
    filteredItems = List.from(widget.items);
    currentPage = widget.initialPage;
    hasMore = widget.hasMoreData;
  }

  void _moveSelectedToTop() {
    if (selectedValue == null) return;
    filteredItems.sort((a, b) {
      if (a == selectedValue) return -1;
      if (b == selectedValue) return 1;
      return 0;
    });
  }

  void _showBottomSheet(BuildContext context, FormFieldState<T> state) async {
    if (!widget.enabled) return;

    searchController.clear();
    filteredItems = List.from(widget.items);
    currentPage = widget.initialPage;
    hasMore = widget.hasMoreData;
    _moveSelectedToTop();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModelState) {
            scrollController.addListener(() {
              if (scrollController.position.pixels >=
                      scrollController.position.maxScrollExtent - 200 &&
                  !isLoadingMore &&
                  hasMore &&
                  widget.hasPagination) {
                _loadMore(setModelState);
              }
            });
            return Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.r),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Container(
                      width: 130.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Padding(
                      padding: EdgeInsetsDirectional.all(16.sp),
                      child: AppTextFieldWidget(
                        controller: searchController,
                        hint: 'search'.tr(),
                        prefixIcon: Icon(Icons.search, color: AppColors.black),
                        onChanged: (query) async {
                          if (!widget.hasPagination) {
                            setModelState(() {
                              filteredItems = widget.items.where((item) {
                                final text = widget.isString
                                    ? item.toString()
                                    : widget.getItemText!(item);
                                return text.toLowerCase().contains(
                                  query!.toLowerCase(),
                                );
                              }).toList();
                              _moveSelectedToTop();
                            });
                            return;
                          }

                          setModelState(() {
                            isLoadingMore = true;
                            currentPage = widget.initialPage;
                            filteredItems.clear();
                          });

                          final result = await widget.onLoadMore!(
                            currentPage,
                            query ?? '',
                          );

                          setModelState(() {
                            filteredItems = result;
                            hasMore = result.isNotEmpty;
                            isLoadingMore = false;
                            _moveSelectedToTop();
                          });
                        },
                        borderColor: AppColors.black.withValues(alpha: 0.05),
                      ),
                    ),
                    Expanded(
                      child: CustomScrollView(
                        controller: scrollController,
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate((
                              context,
                              index,
                            ) {
                              final item = filteredItems[index];
                              final text = widget.isString
                                  ? item.toString()
                                  : widget.getItemText!(item);
                              final isSelected = selectedValue == item;

                              return InkWell(
                                onTap: () {
                                  setState(() => selectedValue = item);
                                  state.didChange(item);
                                  widget.onChanged?.call(item);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: EdgeInsetsDirectional.symmetric(
                                    horizontal: 16.w,
                                    vertical: 14.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColors.primary.withValues(
                                            alpha: 0.06,
                                          )
                                        : null,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey.shade200,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          text,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontSize: 14.sp,
                                                fontWeight: (isSelected)
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                                color: (isSelected)
                                                    ? AppColors.primary
                                                    : AppColors.black,
                                              ),
                                        ),
                                      ),
                                      if (isSelected)
                                        Icon(
                                          Icons.check_circle,
                                          color: AppColors.primary,
                                          size: 20.sp,
                                        ),
                                    ],
                                  ),
                                ),
                              );
                            }, childCount: filteredItems.length),
                          ),
                          if (isLoadingMore)
                            SliverToBoxAdapter(
                              child: Padding(
                                padding: EdgeInsetsDirectional.all(16.h),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _loadMore(StateSetter setModelState) async {
    if (widget.onLoadMore == null) return;

    setModelState(() => isLoadingMore = true);

    final newItems = await widget.onLoadMore!(
      currentPage + 1,
      searchController.text,
    );

    setModelState(() {
      currentPage++;
      filteredItems.addAll(newItems);
      hasMore = newItems.isNotEmpty;
      isLoadingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: selectedValue,
      validator: widget.isHasValidator
          ? widget.validator ??
                (value) => value == null ? 'required'.tr() : null
          : null,
      builder: (state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async => _showBottomSheet(context, state),
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.black.withValues(alpha: 0.2),
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        (selectedValue == null)
                            ? widget.hint ?? 'choose'.tr()
                            : widget.isString
                            ? selectedValue.toString()
                            : widget.getItemText!(selectedValue as T),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          height: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 20.sp,
                      color: AppColors.black.withValues(alpha: 0.2),
                    ),
                  ],
                ),
              ),
            ),
            if (state.hasError) SizedBox(height: 9.h),
            if (state.hasError)
              Padding(
                padding: EdgeInsetsDirectional.only(start: 17.w),
                child: CustomText.titleLarge(
                  'validation.required'.tr(),
                  maxLines: 3,
                  textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}

/// Example
// CustomDropDownMenuButton<CountriesDataModel>(
//   items: context.read<ProfileCubit>().state.countries ?? [],
//   hint: LocaleKeys.country,
//   onChanged: (value) => onSelectCountry,
//   isHasValidator: true,
//   value: _selectedCountry,
//   getItemText: (country) => country.label,
//   isString: false,
// ),
