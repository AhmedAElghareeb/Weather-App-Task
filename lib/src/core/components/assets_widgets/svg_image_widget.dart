import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum SvgImageType { asset, network }

class SvgImageWidget extends StatelessWidget {
  const SvgImageWidget({
    super.key,
    required this.image,
    this.side,
    this.height,
    this.width,
    this.color,
    this.onClick,
    this.imageType = SvgImageType.asset,
  });

  final String image;
  final double? side, height, width;
  final Color? color;
  final VoidCallback? onClick;
  final SvgImageType imageType;

  @override
  Widget build(BuildContext context) {
    switch (imageType) {
      case SvgImageType.asset:
        return InkWell(
          onTap: onClick,
          child: SvgPicture.asset(
            height: height ?? side,
            width: width ?? side,
            image,
            colorFilter: (color != null)
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          ),
        );
      case SvgImageType.network:
        return InkWell(
          onTap: onClick,
          child: SvgPicture.network(
            height: height ?? side,
            width: width ?? side,
            image,
            colorFilter: (color != null)
                ? ColorFilter.mode(color!, BlendMode.srcIn)
                : null,
          ),
        );
    }
  }
}