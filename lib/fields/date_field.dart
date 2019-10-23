import 'package:filters/functions/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateField extends StatefulWidget {
  // if widget is used in Form, pass the Form's key, otherwise pass a GlobalKey()
  final GlobalKey formKey;
  // must have a DateTime argument
  final Function saveData;
  final String errorMessage;

  //keep fields from FormTextField widget
  final TextEditingController controller;
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

  const DateField({
    Key key,
    @required this.formKey,
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
    this.errorMessage = 'Please use dd/mm/yyyy date format',
  })  : assert(saveData != null),
        assert(formKey != null),
        super(key: key);
  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  // Save input as DateTime in state
  DateTime data;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.datetime,
      inputFormatters: [DateInputFormatter()],
      validator: (value) {
        DateTime date = Convert.toDate(value);
        if (date != null) {
          setState(() {
            data = date;
          });
          return null;
        }
        return widget.errorMessage;
      },
      onSaved: (value) {
        widget.saveData(data);
      },
      // keep original widget options
      controller: widget.controller,
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
      onChanged: widget.onChanged,
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
}