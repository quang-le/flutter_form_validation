import 'dart:async';
import 'dart:convert';
import 'package:filters/fields/field.dart';
import 'package:filters/utils/validate.dart';
import 'package:filters/widgets/country.dart';
import 'package:filters/widgets/phone_service.dart';
import 'package:flutter/material.dart';

class PhoneFormField extends StatefulWidget {
  final Function onSaved;
  final String initialPhoneNumber;
  final String initialSelection;
  final String errorText;
  final String hintText;
  final TextStyle errorStyle;
  final TextStyle hintStyle;
  final int errorMaxLines;

  PhoneFormField(
      {this.initialPhoneNumber,
      this.onSaved,
      this.initialSelection,
      this.errorText,
      this.hintText,
      this.errorStyle,
      this.hintStyle,
      this.errorMaxLines});

  // tgis func for test purposes
  static Future<String> internationalizeNumber(String number, String iso) {
    return PhoneService.getNormalizedPhoneNumber(number, iso);
  }

  @override
  _PhoneFormFieldState createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  Country selectedItem;
  List<Country> itemList = [];

  String errorText;
  String hintText;

  TextStyle errorStyle;
  TextStyle hintStyle;

  int errorMaxLines;

  bool hasError = false;

  _PhoneFormFieldState();

  final phoneTextController = TextEditingController();

  @override
  void initState() {
    //phoneTextController.addListener(() => print('ha'));
    phoneTextController.text = widget.initialPhoneNumber;

    _fetchCountryData().then((list) {
      Country preSelectedItem;

      // TODO enforce input type of selected country
      if (widget.initialSelection != null) {
        preSelectedItem = list.firstWhere(
            (e) =>
                (e.code.toUpperCase() ==
                    widget.initialSelection.toUpperCase()) ||
                (e.dialCode == widget.initialSelection.toString()),
            orElse: () => list[0]);
      } else {
        preSelectedItem = list[0];
      }
      setState(() {
        itemList = list;
        selectedItem = preSelectedItem;
      });
    });

    super.initState();
  }

  /* _validatePhoneNumber() {
    String phoneText = phoneTextController.text;
    if (phoneText != null && phoneText.isNotEmpty) {
      PhoneService.parsePhoneNumber(phoneText, selectedItem.code)
          .then((isValid) {
        setState(() {
          hasError = !isValid;
        });

        if (widget.onPhoneNumberChange != null) {
          if (isValid) {
            PhoneService.getNormalizedPhoneNumber(phoneText, selectedItem.code)
                .then((number) {
              widget.onPhoneNumberChange(phoneText, number, selectedItem.code);
            });
          } else {
            widget.onPhoneNumberChange('', '', selectedItem.code);
          }
        }
      });
    }
  }*/

  Future<List<Country>> _fetchCountryData() async {
    var list = await DefaultAssetBundle.of(context)
        .loadString('assets/countries.json');
    var jsonList = json.decode(list);
    List<Country> elements = [];
    jsonList.forEach((s) {
      Map elem = Map.from(s);
      elements.add(Country(
          name: elem['en_short_name'],
          code: elem['alpha_2_code'],
          dialCode: elem['dial_code'],
          flagUri: 'assets/flags/${elem['alpha_2_code'].toLowerCase()}.png'));
    });
    return elements;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          DropdownButtonHideUnderline(
            child: Padding(
              padding: EdgeInsets.only(top: 8),
              child: DropdownButton<Country>(
                value: selectedItem,
                onChanged: (Country newValue) {
                  setState(() {
                    selectedItem = newValue;
                  });
                },
                items: itemList.map<DropdownMenuItem<Country>>((Country value) {
                  return DropdownMenuItem<Country>(
                    value: value,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image(
                              image: AssetImage(
                                value.flagUri,
                              ),
                              width: 32.0),
                          SizedBox(width: 4),
                          Text(value.dialCode)
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Flexible(
            child: Field.phone(
              controller: phoneTextController,
              decoration: InputDecoration(
                labelText: 'phone',
                hintText: widget.hintText ?? 'ex: 47512345',
                //errorText: hasError ? errorText : null,
                hintStyle: widget.hintStyle,
                errorStyle: widget.errorStyle,
                errorMaxLines: widget.errorMaxLines ?? 3,
              ),
              validator: Validate.makePhoneValidator(selectedItem?.code,
                  widget.errorText ?? 'invalid phone number'),
              onSaved: widget.onSaved,
            ),
          )
        ],
      ),
    );
  }
}
