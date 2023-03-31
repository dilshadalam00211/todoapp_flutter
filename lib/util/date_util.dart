import 'package:intl/intl.dart';

class DateUtil {
  static String formatDate(DateTime dateTime, String format) {
    return DateFormat(format).format(dateTime);
  }
}