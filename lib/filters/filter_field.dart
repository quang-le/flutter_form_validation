import 'package:filters/functions/convert.dart';
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
          TextFormField(
            initialValue: 'date field',
            inputFormatters: [DateInputFormatter()],
            validator: (value) {
              try {
                var date = DateTime.parse(value);
                print(date);
                return date.toString();
              } catch (e) {
                print('error parsing date');
                return 'please use correct date input';
              }
            },
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
              }
            },
          )
        ],
      ),
    );
  }
}
