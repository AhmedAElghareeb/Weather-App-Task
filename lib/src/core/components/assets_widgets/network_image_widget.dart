import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class NetworkImageWidget extends StatefulWidget {
  final String image;
  final double? height, width;
  final double? loadingSize;
  final double? radius;
  final BorderRadiusGeometry? radiusOnly;
  final BoxFit? boxFit;

  const NetworkImageWidget({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.loadingSize,
    this.radius,
    this.radiusOnly,
    this.boxFit,
  });

  @override
  State<NetworkImageWidget> createState() => _NetworkImageWidgetState();
}

class _NetworkImageWidgetState extends State<NetworkImageWidget> {
  late ImageStream _imageStream;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _imageStream = Image.network(
      widget.image,
    ).image.resolve(ImageConfiguration.empty);
    _imageStream.addListener(
      ImageStreamListener((ImageInfo info, bool synchronousCall) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _isLoading
            ? SizedBox(
                height: widget.height,
                width: widget.width,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(widget.loadingSize ?? 40),
                    child: SizedBox(
                      height: 35,
                      width: 35,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox(),
        ClipRRect(
          borderRadius:
              widget.radiusOnly ?? BorderRadius.circular(widget.radius ?? 0),
          child: FadeInImage.memoryNetwork(
            height: widget.height,
            width: widget.width,
            image: widget.image,
            fit: widget.boxFit ?? BoxFit.fill,
            placeholder: kTransparentImage,
            placeholderErrorBuilder: (_, value, error) {
              return SizedBox(
                height: widget.height,
                width: widget.width,
                child: const Center(
                  child: Icon(
                    Icons.error_outline,
                    size: 28.0,
                    color: Colors.red,
                  ),
                ),
              );
            },
            imageErrorBuilder: (_, value, error) {
              return SizedBox(
                height: widget.height,
                width: widget.width,
                child: const Center(
                  child: Icon(
                    Icons.error_outline,
                    size: 28.0,
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _imageStream.removeListener(
      ImageStreamListener((ImageInfo info, bool synchronousCall) {}),
    );
    super.dispose();
  }
}
