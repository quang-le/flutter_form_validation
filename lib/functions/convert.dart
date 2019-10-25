import 'package:filters/functions/sanitize.dart';
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

  // format string to use with DateTime.parse. default is dd/mm/yyyy
  static String formatStringForParsing(String str, String format) {
    if (str.length != 10) return null;
    String dateString;
    if (format == 'us') {
      dateString = '${str[6]}'
          '${str[7]}'
          '${str[8]}'
          '${str[9]}-'
          '${str[0]}'
          '${str[1]}-'
          '${str[3]}'
          '${str[4]} '
          '00:00:00Z';
    } else {
      dateString = '${str[6]}'
          '${str[7]}'
          '${str[8]}'
          '${str[9]}-'
          '${str[3]}'
          '${str[4]}-'
          '${str[0]}'
          '${str[1]} '
          '00:00:00Z';
    }
    return dateString;
  }

  // takes a YYYY-MM-DD 00:00:00Z string and checks for the day and month values
  static String checkDateStringFormatting(String str) {
    if (str == null) return null;
    String dayString = str.substring(8, 10),
        monthString = str.substring(5, 7),
        yearString = str.substring(0, 4);
    int day = int.tryParse(dayString), month = int.tryParse(monthString);
    double year = double.tryParse(yearString);

    if (day > 31) return null;
    if (month > 12) return null;
    if (year % 4 == 0 && month == 2 && day > 29) return null;
    if (year % 4 != 0 && month == 2 && day > 28) return null;
    if (day > 30 && (month == 4 || month == 6 || month == 9 || month == 11))
      return null;
    return str;
  }

  // check if string is parsable then DateTime.parse.
  static DateTime toDate(String str) {
    DateTime date;
    try {
      date = DateTime.parse(str);
    } catch (e) {
      print('error parsing date: $e');
      return null;
    }

    return date;
  }

  static bool isValidEmail(String str) {
    RegExp _email = RegExp(
        // r"^(?=[A-Z0-9][A-Z0-9@._%+-]{5,253}+$)[A-Z0-9._%+-]{1,64}+@(?:(?=[A-Z0-9-]{1,63}+\.)[A-Z0-9]++(?:-[A-Z0-9]++)*+\.){1,8}+[A-Z]{2,63}+$");
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
    return _email.hasMatch(str.toLowerCase());
  }
}

// To be used with TextFormField's inputFormatters field
//use 'eur or us to differentiate date formats'
class DateInputFormatter extends TextInputFormatter {
  final String format;
  DateInputFormatter({this.format = 'eur'});
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

class EmailInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String trimmed = newValue.text.trim();
    String sanitized = Sanitize.htmlCharsDelete(trimmed);
    return TextEditingValue(text: sanitized);
  }
}
