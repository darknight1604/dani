import 'package:flutter/material.dart';

import '../utils/text_theme_util.dart';

class InputTextField extends StatelessWidget {
  final int? maxLines;
  const InputTextField({
    super.key,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextThemeUtil.instance.bodyMedium,
      maxLines: maxLines,
      decoration: InputDecoration(
        // border: InputBorder()
        contentPadding: EdgeInsets.all(4.0),
        border: OutlineInputBorder(),
      ),
    );
  }
}
