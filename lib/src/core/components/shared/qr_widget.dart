import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter_new/qr_flutter.dart';

class QRCodeWidget extends StatelessWidget {
  const QRCodeWidget({super.key, required this.code});

  final String? code;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 155.sp,
          width: 155.sp,
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.grey),
          ),
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  AppColors.white,
                  AppColors.white,
                  AppColors.black,
                  AppColors.black,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            child: QrImageView(
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                borderRadius: 4,
                size: 1,
              ),
              data: code ?? '',
              version: QrVersions.auto,
              backgroundColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
