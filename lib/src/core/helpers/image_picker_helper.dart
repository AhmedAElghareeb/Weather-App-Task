import 'dart:io';

import 'package:base_structure/src/core/utils/di.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImagePickerHelper {
  static final ImagePicker _picker = di<ImagePicker>();

  static Future<File?> pickImage({
    ImageSource source = ImageSource.gallery,
    int? quality,
    double? maxHeight,
    double? maxWidth,
    CameraDevice preferredCameraDevice = CameraDevice.front,
  }) async {
    try {
      final XFile? xFile = await _picker.pickImage(
        source: source,
        imageQuality: quality ?? 50,
        maxHeight: maxHeight ?? 1024,
        maxWidth: maxWidth ?? 1024,
        requestFullMetadata: false,
        preferredCameraDevice: source == ImageSource.camera
            ? preferredCameraDevice
            : CameraDevice.rear,
      );
      return xFile != null ? File(xFile.path) : null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<File?>> pickMultipleImages({
    int? quality,
    double? maxHeight,
    double? maxWidth,
  }) async {
    try {
      final List<XFile?> xFiles = await _picker.pickMultiImage(
        imageQuality: quality ?? 50,
        maxHeight: maxHeight ?? 1024,
        maxWidth: maxWidth ?? 1024,
        requestFullMetadata: false,
      );
      final List<File?> files = xFiles
          .map((e) => e != null ? File(e.path) : null)
          .toList();
      return files;
    } catch (e) {
      rethrow;
    }
  }
}
