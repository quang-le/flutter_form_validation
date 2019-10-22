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

  // needs dd/mm/yyyy format
  static DateTime toDate(String str) {
    if (str == null) return null;
    if (str.length != 10) return null;
    DateTime date;
    try {
      date = DateTime.parse('${str[6]}'
          '${str[7]}'
          '${str[8]}'
          '${str[9]}-'
          '${str[3]}'
          '${str[4]}-'
          '${str[0]}'
          '${str[1]} '
          '00:00:00');
    } catch (e) {
      print('error parsing date: $e');
    }
    return date;
  }
}

// To be used with TextFormField's inputFormatters field
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    List<String> chars = newValue.text.split('');
    List<String> filteredChars =
        chars.where((char) => (int.tryParse(char) != null)).toList();

    // keep slashes if placed at the right position
    if (chars.length == 3) if (chars.elementAt(2) == '/') {
      filteredChars.insert(2, '/');
    }
    if (chars.length == 6) if (chars.elementAt(2) == '/' &&
        chars.elementAt(5) == '/') {
      filteredChars.insert(2, '/');
      filteredChars.insert(5, '/');
    }

    int length = filteredChars.length;
    if (length < 3) {
      return TextEditingValue(text: filteredChars.join());
    } else if (length >= 3 && length < 5) {
      if (filteredChars[2] != '/' && filteredChars.length > 2)
        filteredChars.insert(2, '/');
      return TextEditingValue(text: filteredChars.join());
    } else if (length >= 5) {
      if (filteredChars[2] != '/') filteredChars.insert(2, '/');
      if (filteredChars[5] != '/' && filteredChars.length > 5)
        filteredChars.insert(5, '/');
      if (filteredChars.length > 10) {
        filteredChars = filteredChars.take(10).toList();
      }
      return TextEditingValue(text: filteredChars.join());
    }
    return null;
  }
}
