class Validate {
  static bool isValidEmail(String str) {
    RegExp _email = RegExp(
        // r"^(?=[A-Z0-9][A-Z0-9@._%+-]{5,253}+$)[A-Z0-9._%+-]{1,64}+@(?:(?=[A-Z0-9-]{1,63}+\.)[A-Z0-9]++(?:-[A-Z0-9]++)*+\.){1,8}+[A-Z]{2,63}+$");
        r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");
    return _email.hasMatch(str.toLowerCase());
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

  static String date(String value) {
    String formattedForParsing = Validate.formatStringForParsing(value, 'eur');
    if (formattedForParsing == null) return 'Format Error';
    String dateAndMonthValuesInRange =
        Validate.checkDateStringFormatting(formattedForParsing);
    if (dateAndMonthValuesInRange == null) return 'Date not in range';
    DateTime date = Validate.toDate(dateAndMonthValuesInRange);
    if (date != null) {
      return null;
    }
    return 'Please use dd/mm/yyyy format';
  }

  // Allow users to use built-in validator with custom messages and format(EUR vs US)
  static Function customDateValidator(String dateFormat, String formatErrorMsg,
      String dateNotInRangeErrorMsg, String dateErrorMsg) {
    String customDateValidator(String value) {
      String formattedForParsing =
          Validate.formatStringForParsing(value, dateFormat);
      if (formattedForParsing == null) return formatErrorMsg;
      String dateAndMonthValuesInRange =
          Validate.checkDateStringFormatting(formattedForParsing);
      if (dateAndMonthValuesInRange == null) return dateNotInRangeErrorMsg;
      DateTime date = Validate.toDate(dateAndMonthValuesInRange);
      if (date != null) {
        return null;
      }
      return dateErrorMsg;
    }

    return customDateValidator;
  }

  static String name(String value) {
    if (value[0] == '-') return 'Please enter valid name';
    if (value.length < 2) return 'Please enter valid name';
    return null;
  }

  static String email(String value) {
    bool isValid = isValidEmail(value);

    if (isValid) return null;

    return 'please enter valid email';
  }
}
