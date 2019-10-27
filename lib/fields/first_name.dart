import 'dart:ffi';

import 'package:filters/functions/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstNameField extends StatefulWidget {
  // must have a String argument
  final Function saveData;
  final String errorMessage;
  // if no Form parent GlobalKey<FormFieldState> formKey:
  final GlobalKey<FormFieldState> formKey;

  //keep fields from FormTextField widget
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String initialValue;
  final FocusNode focusNode;
  final InputDecoration decoration;
  final TextInputAction textInputAction;
  final TextStyle style;
  final StrutStyle strutStyle;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final bool autofocus;
  final bool readOnly;
  final ToolbarOptions toolbarOptions;
  final bool showCursor;
  final bool obscureText;
  final bool autocorrect;
  final bool autovalidate;
  final bool maxLengthEnforced;
  final int maxLines;
  final int minLines;
  final bool expands;
  final int maxLength;
  final ValueChanged<String> onChanged;
  final GestureTapCallback onTap;
  final VoidCallback onEditingComplete;
  final ValueChanged<String> onFieldSubmitted;
  final bool enabled;
  final double cursorWidth;
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;
  final InputCounterWidgetBuilder buildCounter;

  const FirstNameField({
    Key key,
    @required this.saveData,
    this.focusNode,
    this.controller,
    this.initialValue,
    this.decoration = const InputDecoration(),
    this.textInputAction,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.readOnly = false,
    this.toolbarOptions,
    this.showCursor,
    this.obscureText = false,
    this.autocorrect = true,
    this.autovalidate = false,
    this.maxLengthEnforced = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.enableInteractiveSelection = true,
    this.buildCounter,
    this.errorMessage = 'Please enter valid first name',
    this.formKey,
    this.validator,
  })  : assert(saveData != null),
        super(key: key);
  @override
  _FirstNameFieldState createState() => _FirstNameFieldState();
}

class _FirstNameFieldState extends State<FirstNameField> {
  // Save input as String in state
  String data;
  RegExp forbiddenChars = RegExp(
      r'[0-9"&(§!)°_$*€^¨%£`\/\\;\.,?@#<>≤=+≠÷…∞}ø¡«¶{‘“•®†ºµ¬ﬁ‡‹≈©◊~|´„”\[»\]™ª∏¥‰≥›√ı¿±:]+');
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.formKey,
      keyboardType: TextInputType.text,
      inputFormatters: [
        BlacklistingTextInputFormatter(forbiddenChars),
        FirstNameInputValidator(),
      ],
      onSaved: (value) {
        widget.saveData(data);
      },
      // TODO use key to update state, so users can use own validators
      validator: widget.validator ?? _validator,
      controller: _controller,
      onChanged: (value) {
        Convert.placeCursorAtEndOfText(value, _controller);
      },

      // keep original widget options
      initialValue: widget.initialValue,
      focusNode: widget.focusNode,
      decoration: widget.decoration,
      textInputAction: widget.textInputAction,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textDirection: widget.textDirection,
      textAlign: widget.textAlign,
      autofocus: widget.autofocus,
      autocorrect: widget.autocorrect,
      autovalidate: widget.autovalidate,
      readOnly: widget.readOnly,
      toolbarOptions: widget.toolbarOptions,
      showCursor: widget.showCursor,
      obscureText: widget.obscureText,
      maxLength: widget.maxLength,
      maxLengthEnforced: widget.maxLengthEnforced,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      expands: widget.expands,
      onTap: widget.onTap,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      enabled: widget.enabled,
      cursorColor: widget.cursorColor,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      keyboardAppearance: widget.keyboardAppearance,
      scrollPadding: widget.scrollPadding,
      enableInteractiveSelection: widget.enableInteractiveSelection,
      buildCounter: widget.buildCounter,
    );
  }

  String _validator(String value) {
    if (value[0] == '-') return widget.errorMessage;
    if (value.length < 2) return widget.errorMessage;
    setState(() {
      data = value;
    });
    return null;
  }
}
