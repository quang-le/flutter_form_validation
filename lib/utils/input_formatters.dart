import 'package:filters/utils/sanitize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstNameInputFormatter extends TextInputFormatter {
  String uppercaseAfterSpecialChar(String input, String specialChar) {
    if (input == null || input.length == 0) return input;
    if (!input.contains(specialChar)) return input;

    List<String> parts = input.split(specialChar);
    List<String> transformed =
        List<String>.from(parts.map((part) => firstLetterToUpperCase(part)));
    String result = transformed.join(specialChar);
    print('result: $result');
    return result;
  }

  String firstLetterToUpperCase(String input) {
    if (input == null || input.length == 0) return input;
    print('to uppercase');
    String firstLetter = input[0].toUpperCase();
    String upperCaseFirstLetter = input.replaceRange(0, 1, firstLetter);
    print('uppercased: $upperCaseFirstLetter');
    return upperCaseFirstLetter;
  }

  @override
  //TODO make authorize special char programmable via authorized list
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String input = newValue.text.trimLeft();

    if (input.length == 0) return TextEditingValue(text: input);

    if (!input.contains(' ') && !input.contains('-')) {
      String upperCaseFirstLetter = firstLetterToUpperCase(input);
      return TextEditingValue(text: upperCaseFirstLetter);
    }

    // TODO pass char list i.o hard code chars
    String formattedName = input;
    if (input.contains(' '))
      formattedName = uppercaseAfterSpecialChar(formattedName, ' ');
    if (input.contains('-'))
      formattedName = uppercaseAfterSpecialChar(formattedName, '-');
    return TextEditingValue(text: formattedName);
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
