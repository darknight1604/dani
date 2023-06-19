import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String formatDDMMYYYYHHMMSS() {
    return DateFormat("yyyy-MM-dd hh:mm:ss").format(this);
  }

  String formatHHMMSSDDMMYYYY() {
    return DateFormat("hh:mm:ss yyyy-MM-dd").format(this);
  }

  String formatDDMMYYYY() {
    return DateFormat("yyyy-MM-dd").format(this);
  }

  String formatYYYYMMPlain() {
    return DateFormat("yyyyMM").format(this);
  }

  String formatYYYYMMDDPlain() {
    return DateFormat("yyyyMMdd").format(this);
  }

  /// Compare two days by yyyy-mm-dd
  ///
  bool isEqualByYYYYMMDD(DateTime? other) {
    if (other == null) return false;
    return year == other.year && month == other.month && day == other.day;
  }
}
