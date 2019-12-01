import 'package:filters/fields/field.dart';
import 'package:filters/utils/validate.dart';
import 'package:flutter/material.dart';

class DateOnly extends StatefulWidget {
  @override
  _DateOnlyState createState() => _DateOnlyState();
}

class _DateOnlyState extends State<DateOnly> {
  DateTime testDate;
  // without Form ancestor, you need this GlobalKey to manage validation
  GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        Field.date(
          decoration: InputDecoration(labelText: 'Date'),
          controller: TextEditingController(),
          onSaved: (value) {
            print(value);
          },
          validator: Validate.customDateValidator(DateFormat.eur,
              dateErrorMsg: 'custom error message',
              dateNotInRangeErrorMsg: 'custom msg date not in range'),
        ),
        Spacer(flex: 1),
        RaisedButton(
          child: Text('Save'),
          onPressed: () {
            print(formKey);
            if (formKey.currentState.validate()) {
              print('form is valid');
              formKey.currentState.save();
            }
          },
        ),
      ],
    ));
  }
}
