part of '../utils.dart';

class DateTimeUtils {
  static String getDate(DateTime dateTime) {
    final dateFormat = DateFormat(DateTimeFormatConstants.ddMMyyyy);
    return dateFormat.format(dateTime);
  }

  static String fotmat(int timestamp, String format) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final dateFormat = DateFormat(format);
    return dateFormat.format(date);
  }

  static String getDateFromTimeStamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final dateFormat = DateFormat(DateTimeFormatConstants.ddMMyyyy);
    return dateFormat.format(date);
  }

  static String getTimeAndDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final dateFormat = DateFormat(DateTimeFormatConstants.hHddMMyyyy);
    return '${date.hour}h ${dateFormat.format(date)}';
  }

  static String getTimeBooking(DateTime time) {
    final dateFormat = DateFormat(DateTimeFormatConstants.timeBooking);
    return dateFormat.format(time);
  }

  static DateTime parse(int timestamp) {
    try {
      return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    } catch (_) {
      return DateTime.now();
    }
  }
}
