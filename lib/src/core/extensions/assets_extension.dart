import 'package:base_structure/src/core/helpers/assets_helper.dart';

extension AssetsExtension on String {
  String addImageAsset() {
    return AssetsHelper.baseImagePath + this;
  }

  String addIconAsset() {
    return AssetsHelper.baseIconPath + this;
  }
}
