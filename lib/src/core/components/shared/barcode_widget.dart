import 'package:barcode_widget/barcode_widget.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BarcodeCodeWidget extends StatelessWidget {
  const BarcodeCodeWidget({super.key, required this.code});

  final String? code;

  @override
  Widget build(BuildContext context) {
    final value = code?.trim() ?? '';

    if (value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.grey),
          ),
          child: BarcodeWidget(
            barcode: Barcode.code128(),
            data: value,
            width: 220.w,
            height: 80.h,
            drawText: true,
            color: AppColors.black,
            backgroundColor: Colors.transparent,
            textPadding: 12,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
        ),
      ],
    );
  }
}
