import 'package:base_structure/src/core/utils/di.dart';
import 'package:file_picker/file_picker.dart';

abstract class FilePickerHelper {
  static final FilePicker _picker = di<FilePicker>();

  static Future<PlatformFile?> pickSingleFile({
    List<String>? allowedExtensions,
  }) async {
    PlatformFile? file;
    try {
      final FilePickerResult? result = await _picker.pickFiles(
        type: FileType.custom,
        allowedExtensions:
            allowedExtensions ?? ['pdf', 'png', 'jpg', 'doc', 'docx'],
      );
      file = result?.files.single;
    } catch (e) {
      rethrow;
    }
    return file;
  }

  static Future<List<PlatformFile>> pickMultipleFiles({
    List<String>? allowedExtensions,
  }) async {
    final List<PlatformFile> files = [];
    try {
      final FilePickerResult? result = await _picker.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions:
            allowedExtensions ?? ['pdf', 'png', 'jpg', 'doc', 'docx'],
      );
      if (result != null) {
        files.addAll(result.files);
      } else {
        files.clear();
      }
    } catch (e) {
      rethrow;
    }
    return files;
  }

  ///Android permissions.
  // <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
  // <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
  // <uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
  // <uses-permission android:name="android.permission.READ_MEDIA_VIDEO"/>

  ///IOS permissions.
  // <key>NSCameraUsageDescription</key>
  // <string>The Application Needs To Access Your Camera So User Can Capture Profile Picture.</string>
  // <key>NSPhotoLibraryUsageDescription</key>
  // <string>The Application Needs To Access Your Photo So You Can Send Photo Messages to Providers.</string>
}
