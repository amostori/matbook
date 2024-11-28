import 'package:intl/intl.dart';

class DateTimeAdapter {
  static String getDateTime(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }
}
