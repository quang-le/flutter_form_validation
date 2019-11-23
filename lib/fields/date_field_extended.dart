import 'package:filters/utils/helpers.dart';
import 'package:filters/utils/validate.dart';
import 'package:flutter/material.dart';

class DateFieldExtended extends TextFormField with Validate, TextHelpers {
  final FocusNode focusNode; // testing syntax for super
  DateFieldExtended({this.focusNode, Key key})
      : super(key: key, focusNode: focusNode);
}
