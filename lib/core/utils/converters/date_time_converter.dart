import 'dart:convert';

import 'package:dani/core/utils/string_util.dart';
import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime?, String?> {
  const DateTimeConverter();
  @override
  DateTime? fromJson(String? json) {
    if (StringUtil.isNullOrEmpty(json)) return null;
    return DateTime.parse(json!);
  }

  @override
  String? toJson(DateTime? object) {
    return jsonEncode(object);
  }
}
