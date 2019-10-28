import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Convert {
  // returns null if empty/null input or parse not possible
  static double toDouble(String str) {
    str = str?.trim();
    if (str != null) return double.tryParse(str);
    return null;
  }

  // returns null if empty/null input or parse not possible
  static int toInt(String str) {
    str = str?.trim();
    if (str != null) return int.tryParse(str);
    return null;
  }
}

class TextHelpers {
  // use with onChanged to keep cursor at end of text
  static void placeCursorAtEndOfText(
      String value, TextEditingController controller) {
    controller
      ..text = value
      ..selection = TextSelection.collapsed(offset: controller.text.length);
    return;
  }
}
