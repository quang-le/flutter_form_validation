import 'package:filters/fields/field.dart';
import 'package:flutter/material.dart';

class EmailOnly extends StatefulWidget {
  @override
  _EmailOnlyState createState() => _EmailOnlyState();
}

class _EmailOnlyState extends State<EmailOnly> {
  String testEmail;
  // without Form ancestor, you need this GlobalKey to manage validation
  GlobalKey<FormFieldState> formKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: <Widget>[
        Field.email(
          decoration: InputDecoration(labelText: 'Email'),
          controller: TextEditingController(),
          onSaved: (value) {
            print(value);
          },
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

  String _saveEmail(String fieldValue) {
    String email = fieldValue;
    print('date saved : $email');
    setState(() {
      testEmail = email;
    });
    print('state date : $testEmail');
    return email;
  }
}
