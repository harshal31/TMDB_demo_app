import 'package:intl/intl.dart';

extension FormatDate on String? {
  String get formatDateInMDYFormat {
    try {
      DateTime inputDate = DateTime.parse(this ?? "");
      final DateFormat outputDateFormat = DateFormat("MM/dd/yyyy");
      return outputDateFormat.format(inputDate);
    } catch (e) {
      return "";
    }
  }

  String get formatDateInMMMMFormat {
    try {
      DateTime inputDate = DateTime.parse(this ?? "");

      final DateFormat outputDateFormat = DateFormat("MMMM d, y");

      return outputDateFormat.format(inputDate);
    } catch (e) {
      return "";
    }
  }

  String get yearFromDate {
    try {
      DateTime parsedDate = DateTime.parse(this ?? "");

      final currentYear = DateTime.now().year;
      return "${currentYear - parsedDate.year}";
    } catch (e) {
      return "";
    }
  }

  DateTime? get getDateTime {
    try {
      DateTime parsedDate = DateTime.parse(this ?? "");
      return parsedDate;
    } catch (e) {
      return null;
    }
  }
}
