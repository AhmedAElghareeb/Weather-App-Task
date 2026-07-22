import 'dart:io';

import 'package:flutter/material.dart';

enum ImageType { asset, file, network }

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.imageType = ImageType.asset,
    this.radius = 0,
    this.assetImage,
    this.fileImage,
    this.networkImage,
    this.height,
    this.width,
    this.color,
    this.fit,
  });

  final String? assetImage;
  final File? fileImage;
  final String? networkImage;
  final double? height, width;
  final BoxFit? fit;
  final Color? color;
  final ImageType imageType;
  final double radius;

  @override
  Widget build(BuildContext context) {
    switch (imageType) {
      case ImageType.asset:
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.asset(
            assetImage!,
            fit: fit ?? BoxFit.fill,
            height: height,
            width: width,
            color: color,
          ),
        );
      case ImageType.file:
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.file(
            fileImage!,
            fit: fit ?? BoxFit.fill,
            height: height,
            width: width,
            color: color,
          ),
        );
      case ImageType.network:
        return ClipRRect(
          borderRadius: BorderRadius.circular(radius),
          child: Image.network(
            networkImage!,
            fit: fit ?? BoxFit.fill,
            height: height,
            width: width,
            color: color,
          ),
        );
    }
  }
}
