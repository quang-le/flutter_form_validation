import 'package:filters/fields/date_field.dart';
import 'package:flutter/material.dart';

class DateOnly extends StatefulWidget {
  @override
  _DateOnlyState createState() => _DateOnlyState();
}

class _DateOnlyState extends State<DateOnly> {
  DateTime testDate;
  GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        DateField(
          decoration: InputDecoration(labelText: 'Date'),
          formKey: formKey,
          saveData: _saveDate,
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

  DateTime _saveDate(DateTime fieldValue) {
    DateTime date = fieldValue;
    print('date saved : $date');
    setState(() {
      testDate = date;
    });
    print('state date : $testDate');
    return date;
  }
}
