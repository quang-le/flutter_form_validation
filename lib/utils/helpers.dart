import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Convert {
  // returns null if empty/null input or parse not possible
  double toDouble(String str) {
    str = str?.trim();
    if (str != null) return double.tryParse(str);
    return null;
  }

  // returns null if empty/null input or parse not possible
  int toInt(String str) {
    str = str?.trim();
    if (str != null) return int.tryParse(str);
    return null;
  }
}

class TextHelpers {
  // use with onChanged to keep cursor at end of text
  void placeCursorAtEndOfText(String value, TextEditingController controller) {
    controller
      ..text = value
      ..selection = TextSelection.collapsed(offset: controller.text.length);
    return;
  }

  RegExp namesRegExp() {
    return RegExp(
        r'[0-9"&(§!)°_$*€^¨%£`\/\\;\.,?@#<>≤=+≠÷…∞}ø¡«¶{‘“•®†ºµ¬ﬁ‡‹≈©◊~|´„”\[»\]™ª∏¥‰≥›√ı¿±:]+');
  }

  List<String> nameParticles() {
    List<String> list = [
      //french
      "de",
      "du",
      "des",
      "d’",
      //spanish
      "del",
      "la",
      "los",
      "las",
      "y",
      //portuguese
      "a",
      "da",
      "das",
      "do",
      "dos",
      //dutch
      "den",
      "op",
      "t’",
      "’t",
      "ten",
      "ter",
      "te",
      "van",
      "vanden",
      "den",
      "vander",
      //german
      "von",
      "aus",
      "der",
      "am",
      "an",
      "auf",
      "im",
      "zu",
      "zum",
      "zur",
      //english
      "of",
      //scandinavian languages
      "af",
      "av",
    ];
    return list;
  }
}
