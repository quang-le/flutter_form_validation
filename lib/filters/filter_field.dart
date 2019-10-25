import 'package:filters/fields/date_field.dart';
import 'package:flutter/material.dart';

class FilterFields extends StatefulWidget {
  @override
  _FilterFieldsState createState() => _FilterFieldsState();
}

class _FilterFieldsState extends State<FilterFields> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Use Form to validate several fields at once
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            initialValue: 'name field',
            autocorrect: false,
            // use validator to sanitize and validate
            validator: (value) {
              if (value is String && value.isNotEmpty) {
                return null;
              }
              return 'Please type in your name';
            },
          ),
          DateField(
            saveData: _saveDate,
          ),
          TextFormField(
            initialValue: 'email field',
            validator: (value) {
              if (value is String && value.isNotEmpty) {
                return null;
              }
              print('Please type in your email');
              // return the error message that will be displayed under the field
              return 'Please type in your email';
            },
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                print('form is valid');
                _formKey.currentState.save();
              }
            },
          )
        ],
      ),
    );
  }

  void _saveDate(DateTime date) {
    print('date entered is $date');
    return;
  }
}
