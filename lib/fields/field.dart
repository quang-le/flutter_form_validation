import 'package:filters/utils/helpers.dart';
import 'package:filters/utils/input_formatters.dart';
import 'package:filters/utils/validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Field extends TextFormField with Validate, TextHelpers {
  final String dateErrorMessage;
  final String dateFormatError;
  final String dateNotInRange;
  final String dateFormat;

  Field.textForm(
      {this.dateErrorMessage = 'Please use dd/mm/yyyy date format',
      this.dateFormatError = 'format error',
      this.dateNotInRange = 'dates not in range',
      this.dateFormat = 'eur',
      Key key,
      FocusNode focusNode,
      TextEditingController controller,
      String initialValue,
      InputDecoration decoration = const InputDecoration(),
      TextInputAction textInputAction,
      TextStyle style,
      StrutStyle strutStyle,
      TextDirection textDirection,
      TextAlign textAlign = TextAlign.start,
      ToolbarOptions toolbarOptions,
      bool autofocus = false,
      bool readOnly = false,
      bool showCursor,
      bool obscureText = false,
      bool autocorrect = true,
      bool autovalidate = false,
      bool maxLengthEnforced = true,
      int maxLines = 1,
      int minLines,
      bool expands = false,
      int maxLength,
      ValueChanged<String> onChanged,
      GestureTapCallback onTap,
      VoidCallback onEditingComplete,
      ValueChanged<String> onFieldSubmitted,
      bool enabled = true,
      double cursorWidth = 2.0,
      Radius cursorRadius,
      Color cursorColor,
      Brightness keyboardAppearance,
      EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
      bool enableInteractiveSelection = true,
      InputCounterWidgetBuilder buildCounter,
      GlobalKey formKey,
      FormFieldValidator<String> validator,
      List<TextInputFormatter> inputFormatters,
      FormFieldSetter<String> onSaved,
      TextInputType keyboardType})
      : super(
            key: formKey ?? key,
            focusNode: focusNode,
            controller: controller,
            initialValue: initialValue,
            decoration: decoration,
            textInputAction: textInputAction,
            style: style,
            strutStyle: strutStyle,
            textDirection: textDirection,
            textAlign: textAlign,
            autofocus: autofocus,
            readOnly: readOnly,
            toolbarOptions: toolbarOptions,
            showCursor: showCursor,
            obscureText: obscureText,
            autocorrect: autocorrect,
            autovalidate: autovalidate,
            maxLengthEnforced: maxLengthEnforced,
            maxLines: maxLines,
            minLines: minLines,
            expands: expands,
            maxLength: maxLength,
            onChanged: onChanged,
            onTap: onTap,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmitted,
            enabled: enabled,
            cursorWidth: cursorWidth,
            cursorRadius: cursorRadius,
            cursorColor: cursorColor,
            keyboardAppearance: keyboardAppearance,
            scrollPadding: scrollPadding,
            enableInteractiveSelection: enableInteractiveSelection,
            buildCounter: buildCounter,
            validator: validator,
            inputFormatters: inputFormatters,
            onSaved: onSaved,
            keyboardType: keyboardType);

  Field.date({
    Key key,
    this.dateErrorMessage = 'Please use dd/mm/yyyy date format',
    this.dateFormatError = 'format error',
    this.dateNotInRange = 'dates not in range',
    this.dateFormat = 'eur',
    FocusNode focusNode,
    TextEditingController controller,
    String initialValue,
    InputDecoration decoration = const InputDecoration(),
    TextInputAction textInputAction,
    TextStyle style,
    StrutStyle strutStyle,
    TextDirection textDirection,
    TextAlign textAlign = TextAlign.start,
    ToolbarOptions toolbarOptions,
    bool autofocus = false,
    bool readOnly = false,
    bool showCursor,
    bool obscureText = false,
    bool autocorrect = true,
    bool autovalidate = false,
    bool maxLengthEnforced = true,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    int maxLength,
    ValueChanged<String> onChanged,
    GestureTapCallback onTap,
    VoidCallback onEditingComplete,
    ValueChanged<String> onFieldSubmitted,
    bool enabled = true,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder buildCounter,
    GlobalKey formKey,
    FormFieldSetter<String> onSaved,
    TextInputType keyboardType,
    FormFieldValidator<String> validator = Validate.dateValidator,
    //List<TextInputFormatter> inputFormatters = [DateInputFormatter()],
  }) : super(
          key: formKey ?? key,
          focusNode: focusNode,
          controller: controller,
          initialValue: initialValue,
          decoration: decoration,
          textInputAction: textInputAction,
          style: style,
          strutStyle: strutStyle,
          textDirection: textDirection,
          textAlign: textAlign,
          autofocus: autofocus,
          readOnly: readOnly,
          toolbarOptions: toolbarOptions,
          showCursor: showCursor,
          obscureText: obscureText,
          autocorrect: autocorrect,
          autovalidate: autovalidate,
          maxLengthEnforced: maxLengthEnforced,
          maxLines: maxLines,
          minLines: minLines,
          expands: expands,
          maxLength: maxLength,
          onChanged: onChanged,
          onTap: onTap,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          enabled: enabled,
          cursorWidth: cursorWidth,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor,
          keyboardAppearance: keyboardAppearance,
          scrollPadding: scrollPadding,
          enableInteractiveSelection: enableInteractiveSelection,
          buildCounter: buildCounter,
          validator: validator,
          inputFormatters: [DateInputFormatter()],
          onSaved: onSaved,
          keyboardType: keyboardType,
        );
}
