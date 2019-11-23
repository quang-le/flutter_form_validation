import 'package:filters/utils/helpers.dart';
import 'package:filters/utils/input_formatters.dart';
import 'package:filters/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DateField extends StatefulWidget {
  // must have a DateTime argument
  final Function saveData;
  final String errorMessage;
  final String dateNotInRange; // move to validator mixin
  final String formatError;
  final String
      format; // TODO find a way to handle that with constructor (create specific child class and use factory?)
  // if DateField doesn't have a Form parent, formKey is necessary
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
  // TextInputFormatter _inputFormatter=DateInputFormatter();

  const DateField({
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
    this.errorMessage = 'Please use dd/mm/yyyy date format',
    this.format = 'eur',
    this.dateNotInRange = 'dates not in range',
    this.formatError = 'format error',
    this.formKey,
    this.validator,
  })  : assert(saveData != null),
        super(key: key);
  @override
  _DateFieldState createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> with TextHelpers, Validate {
  // Save input as DateTime in state
  DateTime data;
  TextEditingController _controller;

  @override
  void initState() {
    // TODO: implement initState
    _controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.formKey,
      keyboardType: TextInputType.datetime,
      inputFormatters: [DateInputFormatter()],
      validator: widget.validator ?? _validator,
      onSaved: (value) {
        widget.saveData(data);
      },
      controller: _controller,
      onChanged: (value) {
        placeCursorAtEndOfText(value, _controller);
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
    String formattedForParsing = formatStringForParsing(value, widget.format);
    if (formattedForParsing == null) return widget.formatError;
    String dateAndMonthValuesInRange =
        Validate.checkDateStringFormatting(formattedForParsing);
    if (dateAndMonthValuesInRange == null) return widget.dateNotInRange;
    DateTime date = Validate.toDate(dateAndMonthValuesInRange);
    if (date != null) {
      setState(() {
        data = date;
      });
      return null;
    }
    return widget.errorMessage;
  }
}
