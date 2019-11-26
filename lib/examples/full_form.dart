import 'package:filters/fields/date_field.dart';
import 'package:filters/fields/field.dart';
import 'package:filters/fields/email_field.dart';
import 'package:filters/fields/first_name.dart';
import 'package:filters/fields/last_name.dart';
import 'package:filters/utils/validate.dart';
import 'package:flutter/material.dart';

class FullForm extends StatefulWidget {
  @override
  _FullFormState createState() => _FullFormState();
}

class _FullFormState extends State<FullForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Use Form to validate several fields at once
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          /*FirstNameField(
            decoration: InputDecoration(labelText: 'First Name'),
            saveData: _saveFirstName,
          ),
          LastNameField(
            decoration: InputDecoration(labelText: 'Last Name'),
            saveData: _saveLastName,
          ),
          DateField(
            decoration: InputDecoration(labelText: 'Date'),
            saveData: _saveDate,
          ),
          EmailField(
            decoration: InputDecoration(labelText: 'Email'),
            saveData: _saveEmail,
          ),*/
          Field.date(
            keyboardAppearance: Brightness.light,
            decoration: InputDecoration(labelText: 'test widget'),
            onSaved: (value) {
              print(value);
            },
            validator:
                Validate.customDateValidator('eur', 'prout', 'caca', 'boudin'),
          ),
          TextFormField(),
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

  String _saveEmail(String email) {
    print('email entered is $email');
    return email;
  }

  void _saveFirstName(String firstName) {
    print('first name entered is $firstName');
    return;
  }

  void _saveLastName(String lastName) {
    print('last name entered is $lastName');
    return;
  }
}
