import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TitledCurvedWidget extends StatelessWidget {
  const TitledCurvedWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomPaint(
            size: Size(double.infinity, 100.h),
            painter: CurvedContainerPainter(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: CustomText.titleLarge(
              title,
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedContainerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff4A425D)
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start from the top-left corner
    path.moveTo(0, 0);

    // Draw a straight line to the top-right corner
    path.lineTo(size.width, 0);

    // Draw a straight line to the bottom-right corner
    path.lineTo(size.width, size.height * 0.8);

    // Draw the bottom-right rounded corner
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height,
      size.width * 0.5,
      size.height,
    );

    // Draw the bottom-left rounded corner
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      0,
      size.height * 0.8,
    );

    // Close the path
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
