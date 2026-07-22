import 'dart:io';

extension FileSize on File {
  double fileSize() {
    final int sizeInBytes = lengthSync();
    final double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb;
  }
}

extension CheckFileSize on File {
  bool isBigSize(int megabytes) {
    final int sizeInBytes = lengthSync();
    final double sizeInMb = sizeInBytes / (1024 * 1024);
    return sizeInMb > megabytes;
  }
}

extension FileNameExtractor on File {
  String get fileName => path.split(Platform.pathSeparator).last;
}

extension FileExtensionExtractor on File {
  String get fileExtension {
    final name = path.split(Platform.pathSeparator).last;
    return name.contains('.') ? name.split('.').last : '';
  }
}
