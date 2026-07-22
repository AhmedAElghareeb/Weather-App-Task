import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:pdf_manipulator/pdf_manipulator.dart';

abstract class FileCompressionHelper {
  // static final PdfManipulator _pdfManipulator = locator<PdfManipulator>();

  static Future<File?> compressAndGetFile(
    File file,
    String targetPath, {
    required String extension,
  }) async {
    try {
      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 50,
        rotate: 0,
        format: extension == 'png' ? CompressFormat.png : CompressFormat.jpeg,
      );
      if (result != null) {
        return File(result.path);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return file;
    }
  }

  static Future<File?> compressPdfFile({required String pdfPath}) async {
    return File(pdfPath);
    // final String? compressedPdfPath = await _pdfManipulator.pdfCompressor(
    //   params: PDFCompressorParams(
    //     pdfPath: pdfPath,
    //     imageQuality: 50,
    //     imageScale: 1,
    //   ),
    // );
    // if (compressedPdfPath != null) {
    //   return File(compressedPdfPath);
    // } else {
    //   return null;
    // }
  }
}
