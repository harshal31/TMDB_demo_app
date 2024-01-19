import 'package:intl/intl.dart';

extension FormatTime on int? {
  String get formatTimeInHM {
    try {
      Duration duration = Duration(minutes: this ?? 0);
      int hours = duration.inHours;
      int minutes = duration.inMinutes % 60;
      String formattedDuration = "${hours}h ${minutes}m";
      return formattedDuration;
    } catch (e) {
      return "";
    }
  }
}
