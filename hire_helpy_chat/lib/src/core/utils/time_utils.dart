import 'package:intl/intl.dart';

String apiDatetimeToLocal(String datetimeString, String outputFormat) {
  final inputFormatter = DateFormat("yyyy-MM-dd HH:mm:ss");
  final outputFormatter = DateFormat(outputFormat); /// example "dd.MM.yyyy HH:mm"
  final utcDateTime = inputFormatter.parse(datetimeString, true);
  final localDateTime = utcDateTime.toLocal();
  return outputFormatter.format(localDateTime);
}

String formatDate(String dateString, String outputFormat) {
  final inputFormatter = DateFormat("yyyy-MM-dd");
  final outputFormatter = DateFormat(outputFormat); /// example "dd.MM.yyyy"
  final utcDateTime = inputFormatter.parse(dateString, true);
  final localDateTime = utcDateTime.toLocal();
  return outputFormatter.format(localDateTime);
}

String datetimeToLocal(DateTime datetime, String outputFormat) {
  final outputFormatter = DateFormat(outputFormat);
  final localDateTime = datetime.toLocal();
  return outputFormatter.format(localDateTime);
}
