import 'package:flutter/services.dart';

abstract class CopyTextHelper {
  static void copyText({required String text}) =>
      Clipboard.setData(ClipboardData(text: text));
}
