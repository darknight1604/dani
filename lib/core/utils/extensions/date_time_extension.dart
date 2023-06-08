import 'package:easy_localization/easy_localization.dart';

extension DateTimeExtension on DateTime {
  String formatDDMMYYYYHHMMSS() {
    return DateFormat("yyyy-MM-dd hh:mm:ss").format(this);
  }

  String formatHHMMSSDDMMYYYY() {
    return DateFormat("hh:mm:ss yyyy-MM-dd").format(this);
  }
}
