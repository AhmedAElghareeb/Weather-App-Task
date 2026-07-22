import 'dart:io';

import 'package:base_structure/src/core/components/assets_widgets/image_widget.dart';
import 'package:base_structure/src/core/components/text_widget/custom_text_widget.dart';
import 'package:base_structure/src/core/extensions/assets_extension.dart';
import 'package:base_structure/src/core/helpers/file_compression_helper.dart';
import 'package:base_structure/src/core/utils/app_spaces.dart';
import 'package:base_structure/src/core/utils/app_theme/app_colors.dart';
import 'package:base_structure/src/core/utils/app_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class UniversalUploadWidget extends StatefulWidget {
  final Function(List<File> files) onFilesSelected;
  final bool allowMultiple;
  final Color? primaryColor;
  final double maxSizeInMB;

  const UniversalUploadWidget({
    super.key,
    required this.onFilesSelected,
    this.allowMultiple = false,
    this.primaryColor,
    this.maxSizeInMB = 5.0,
  });

  @override
  State<UniversalUploadWidget> createState() => _UniversalUploadWidgetState();
}

class _UniversalUploadWidgetState extends State<UniversalUploadWidget> {
  final List<File> _selectedFiles = [];
  final ImagePicker _picker = ImagePicker();
  bool _isProcessing = false;

  Future<File?> _processFile(File file) async {
    try {
      final String fileName = p.basename(file.path);
      final String extension = p
          .extension(file.path)
          .toLowerCase()
          .replaceAll('.', '');
      final Directory tempDir = await getTemporaryDirectory();

      final String targetPath = p.join(tempDir.path, 'compressed_$fileName');

      if (['jpg', 'jpeg', 'png'].contains(extension)) {
        final compressedImage = await FileCompressionHelper.compressAndGetFile(
          file,
          targetPath,
          extension: extension,
        );
        return compressedImage ?? file;
      }

      if (extension == 'pdf') {
        final compressedPdf = await FileCompressionHelper.compressPdfFile(
          pdfPath: file.path,
        );
        return compressedPdf ?? file;
      }
      return file;
    } catch (e) {
      debugPrint("Processing Error: $e");
      return file;
    }
  }

  Future<void> _pickFiles(SourceType type) async {
    Navigator.pop(context);
    List<File> rawPicked = [];

    try {
      if (type == SourceType.camera) {
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.camera,
        );
        if (photo != null) rawPicked.add(File(photo.path));
      } else if (type == SourceType.gallery) {
        if (widget.allowMultiple) {
          final List<XFile> images = await _picker.pickMultiImage();
          rawPicked.addAll(images.map((e) => File(e.path)));
        } else {
          final XFile? image = await _picker.pickImage(
            source: ImageSource.gallery,
          );
          if (image != null) rawPicked.add(File(image.path));
        }
      } else {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: widget.allowMultiple,
          type: FileType.any,
        );
        if (result != null && result.paths.isNotEmpty) {
          rawPicked.addAll(
            result.paths.whereType<String>().map((path) => File(path)),
          );
        }
      }

      if (rawPicked.isEmpty) return;

      setState(() => _isProcessing = true);

      List<File> processedFiles = [];
      for (var file in rawPicked) {
        File? processed = await _processFile(file);

        if (processed != null) {
          final double fileSizeMB = processed.lengthSync() / (1024 * 1024);
          if (fileSizeMB <= widget.maxSizeInMB) {
            processedFiles.add(processed);
          } else {
            AppToast.showError('maxSize'.tr());
          }
        }
      }

      if (processedFiles.isNotEmpty) {
        setState(() {
          if (widget.allowMultiple) {
            _selectedFiles.addAll(processedFiles);
          } else {
            _selectedFiles.clear();
            _selectedFiles.addAll(processedFiles);
          }
        });
        widget.onFilesSelected(_selectedFiles);
      }
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _isProcessing ? null : () => _showPickerSheet(context),
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              strokeWidth: 1,
              color: AppColors.grey,
              strokeCap: StrokeCap.square,
              radius: const Radius.circular(12).r,
              dashPattern: const [6, 3],
            ),
            child: Container(
              width: double.infinity,
              height: 110.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12).r,
                color: (widget.primaryColor ?? const Color(0xff005FAD))
                    .withValues(alpha: 0.05),
              ),
              child: _isProcessing
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageWidget(
                          assetImage: 'upload.png'.addImageAsset(),
                          color: Colors.black,
                        ),
                        AppSpaces.verticalSpace1,
                        RichText(
                          text: TextSpan(
                            text: 'select_file'.tr(),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      widget.primaryColor ??
                                      const Color(0xff005FAD),
                                ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
        if (_selectedFiles.isNotEmpty) ...[
          AppSpaces.verticalSpace2,
          _buildFilePreview(),
        ],
      ],
    );
  }

  Widget _buildFilePreview() {
    return SizedBox(
      height: 90.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _selectedFiles.length,
        separatorBuilder: (context, index) => AppSpaces.horizontalSpace2,
        itemBuilder: (context, index) {
          final file = _selectedFiles[index];
          final isImage = [
            'jpg',
            'jpeg',
            'png',
          ].contains(p.extension(file.path).toLowerCase().replaceAll('.', ''));

          return Stack(
            children: [
              Container(
                width: 85.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColors.grey.withValues(alpha: 0.3),
                  ),
                  color: AppColors.grey,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: isImage
                      ? Image.file(file, fit: BoxFit.cover)
                      : Center(
                          child: Icon(
                            Icons.insert_drive_file,
                            color: widget.primaryColor,
                          ),
                        ),
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _selectedFiles.removeAt(index));
                    widget.onFilesSelected(_selectedFiles);
                  },
                  child: CircleAvatar(
                    radius: 10.r,
                    backgroundColor: Colors.red.withValues(alpha: 0.8),
                    child: Icon(Icons.close, size: 12.sp, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showPickerSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (_) => _PickerBottomSheet(
        primaryColor: widget.primaryColor ?? const Color(0xff005FAD),
        onSourceSelected: _pickFiles,
      ),
    );
  }
}

enum SourceType { camera, gallery, file }

class _PickerBottomSheet extends StatelessWidget {
  final Color primaryColor;
  final Future<void> Function(SourceType) onSourceSelected;

  const _PickerBottomSheet({
    required this.primaryColor,
    required this.onSourceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag Handle
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColors.grey.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // Title
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  'select_file'.tr(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Options
              _SheetOption(
                icon: Icons.camera_alt_outlined,
                label: 'camera'.tr(),
                primaryColor: primaryColor,
                onTap: () => onSourceSelected(SourceType.camera),
              ),
              SizedBox(height: 10.h),
              _SheetOption(
                icon: Icons.photo_library_outlined,
                label: 'gallery'.tr(),
                primaryColor: primaryColor,
                onTap: () => onSourceSelected(SourceType.gallery),
              ),
              SizedBox(height: 10.h),
              _SheetOption(
                icon: Icons.insert_drive_file_outlined,
                label: 'file'.tr(),
                primaryColor: primaryColor,
                onTap: () => onSourceSelected(SourceType.file),
              ),
              SizedBox(height: 12.h),

              // Cancel
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      side: BorderSide(
                        color: AppColors.grey.withValues(alpha: 0.3),
                      ),
                    ),
                  ),
                  child: Text(
                    'cancel'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grey,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color primaryColor;
  final VoidCallback onTap;

  const _SheetOption({
    required this.icon,
    required this.label,
    required this.primaryColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Ink(
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(icon, color: primaryColor, size: 20.sp),
                ),
                SizedBox(width: 14.w),
                CustomText.bodyMedium(
                  label,
                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14.sp,
                  color: AppColors.grey.withValues(alpha: 0.5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
