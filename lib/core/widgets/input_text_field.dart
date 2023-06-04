import 'package:alpha/core/constants.dart';
import 'package:flutter/material.dart';

import '../utils/text_theme_util.dart';

class InputTextField extends StatelessWidget {
  final int? maxLines;
  final String? labelText;
  final String? hintText;
  final Widget? hintWidget;
  final Widget? labelWidget;
  final TextEditingController? controller;
  final void Function(String value)? onChanged;
  final String? prefixText;
  final String? suffixText;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const InputTextField({
    super.key,
    this.maxLines,
    this.labelText,
    this.controller,
    this.onChanged,
    this.prefixText,
    this.keyboardType,
    this.suffixText,
    this.onSaved,
    this.validator,
    this.hintText,
    this.hintWidget,
    this.labelWidget,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextThemeUtil.instance.bodyMedium,
      maxLines: maxLines,
      onChanged: onChanged,
      keyboardType: keyboardType,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        // border: InputBorder()
        alignLabelWithHint: true,
        hintText: hintText,
        hintStyle: TextThemeUtil.instance.bodyMedium?.copyWith(
          color: Constants.disableColor,
        ),
        label: labelWidget,
        labelText: labelText,
        labelStyle: TextThemeUtil.instance.bodyMedium?.copyWith(
          color: Colors.black,
        ),
        prefixText: prefixText,
        prefixStyle: TextThemeUtil.instance.bodyMedium?.copyWith(
          color: Constants.disableColor,
        ),
        suffixText: suffixText,
        suffixStyle: TextThemeUtil.instance.bodyMedium?.copyWith(
          color: Constants.disableColor,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        border: OutlineInputBorder(),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
  }
}
