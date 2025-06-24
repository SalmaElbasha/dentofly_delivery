import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateConverter {

  static String formatDate(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss a').format(dateTime);
  }

  static String dateToTimeOnly(DateTime dateTime) {
    return DateFormat(_timeFormatter()).format(dateTime);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm').format(dateTime);
  }

  static String dateToDateAndTimeAm(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd ${_timeFormatter()}').format(dateTime);
  }

  static DateTime? dateTimeStringToDateTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return null;
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
    } catch (e) {
      return null;
    }
  }

  static String dateTimeStringToDateOnly(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'Invalid Date';
    try {
      return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime));
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static DateTime? dateTimeStringToDate(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return null;
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateTime);
    } catch (e) {
      return null;
    }
  }

  static DateTime isoStringToLocalDate(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return DateTime.now();
    }
    try {
      return DateTime.parse(dateTime).toLocal();
    } catch (e) {
      return DateTime.now();
    }
  }

  static String isoStringToLocalString(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'Invalid Date';
    try {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(dateTime).toLocal());
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String isoStringToDateTimeString(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'Invalid Date';
    try {
      return DateFormat('dd MMM yyyy  ${_timeFormatter()}').format(isoStringToLocalDate(dateTime));
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String isoStringToLocalDateOnly(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'Invalid Date';
    try {
      return DateFormat('dd MMM yyyy').format(isoStringToLocalDate(dateTime));
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String stringToLocalDateOnly(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'Invalid Date';
    try {
      return DateFormat('dd MMM yyyy').format(DateFormat('yyyy-MM-dd').parse(dateTime));
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String localDateToIsoString(DateTime dateTime) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(dateTime);
  }

  static String convertTimeToTime(String time) {
    try {
      return DateFormat(_timeFormatter()).format(DateFormat('HH:mm').parse(time));
    } catch (e) {
      return 'Invalid Time';
    }
  }

  static String convertStringTimeToDate(DateTime time) {
    return DateFormat('EEE \'at\' ${_timeFormatter()}').format(time.toLocal());
  }

  static String _timeFormatter() {
    return 'hh:mm a';
  }

  static String convertStringTimeToDateChatting(DateTime time) {
    return DateFormat('EEE \'at\' ${_timeFormatter()}').format(time.toLocal());
  }

  static String dateStringMonthYear(DateTime? dateTime) {
    if (dateTime == null) return 'Invalid Date';
    return DateFormat('d MMM,y').format(dateTime);
  }

  static DateTime isoUtcStringToLocalTimeOnly(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return DateTime.now();
    try {
      return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
    } catch (e) {
      return DateTime.now();
    }
  }

  static String isoStringToLocalDateAndTime(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'Invalid Date';
    try {
      return DateFormat('dd-MMM-yyyy hh:mm a').format(isoStringToLocalDate(dateTime));
    } catch (e) {
      return 'Invalid Date';
    }
  }

  static String convert24HourTimeTo12HourTimeWithDay(DateTime time, bool isToday) {
    if (isToday) {
      return DateFormat('\'Today at\' ${_timeFormatter()}').format(time);
    } else {
      return DateFormat('\'Yesterday at\' ${_timeFormatter()}').format(time);
    }
  }

  static String convert24HourTimeTo12HourTime(DateTime time) {
    return DateFormat(_timeFormatter()).format(time);
  }

  static String convertFromMinute(int minMinute, int maxMinute) {
    int _firstValue = minMinute;
    int _secondValue = maxMinute;
    String _type = 'min';
    if (minMinute >= 525600) {
      _firstValue = (minMinute / 525600).floor();
      _secondValue = (maxMinute / 525600).floor();
      _type = 'year';
    } else if (minMinute >= 43200) {
      _firstValue = (minMinute / 43200).floor();
      _secondValue = (maxMinute / 43200).floor();
      _type = 'month';
    } else if (minMinute >= 10080) {
      _firstValue = (minMinute / 10080).floor();
      _secondValue = (maxMinute / 10080).floor();
      _type = 'week';
    } else if (minMinute >= 1440) {
      _firstValue = (minMinute / 1440).floor();
      _secondValue = (maxMinute / 1440).floor();
      _type = 'day';
    } else if (minMinute >= 60) {
      _firstValue = (minMinute / 60).floor();
      _secondValue = (maxMinute / 60).floor();
      _type = 'hour';
    }
    return '$_firstValue-$_secondValue ${_type.tr}';
  }

  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('${_timeFormatter()} | d-MMM-yyyy ').format(dateTime.toLocal());
  }

  static String localToIsoString(DateTime dateTime) {
    return DateFormat('d MMMM, yyyy ').format(dateTime.toLocal());
  }

  static int countDays(DateTime? dateTime) {
    if (dateTime == null) return 0;
    final startDate = dateTime;
    final endDate = DateTime.now();
    final difference = endDate.difference(startDate).inDays;
    return difference;
  }

  static String getRelativeDateStatus(String? inputDate, BuildContext context) {
    if (inputDate == null || inputDate.isEmpty) return 'invalid_date'.tr;
    try {
      final parsedDate = DateTime.parse(inputDate);
      final currentDate = DateTime.now();
      final normalizedParsedDate = DateTime(parsedDate.year, parsedDate.month, parsedDate.day);
      final normalizedCurrentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
      final difference = normalizedCurrentDate.difference(normalizedParsedDate).inDays;

      if (difference == 0) {
        return 'today'.tr;
      } else if (difference == 1) {
        return 'yesterday'.tr;
      } else {
        return DateFormat('MM/dd/yyyy').format(parsedDate);
      }
    } catch (e) {
      return 'invalid_date'.tr;
    }
  }

  static String compareDates(String? inputDate) {
    if (inputDate == null || inputDate.isEmpty) return 'invalid_date'.tr;
    try {
      DateTime currentDate = DateTime.now();
      DateTime parsedDate = DateTime.parse(inputDate);

      Duration difference = currentDate.difference(parsedDate);
      int hoursDifference = difference.inHours;
      int daysDifference = difference.inDays;

      if (hoursDifference < 1) {
        return DateFormat('hh:mm a').format(parsedDate);
      } else if (hoursDifference >= 1 && hoursDifference <= 23) {
        return 'hr_ago'.tr;
      } else if (daysDifference == 1) {
        return 'yesterday'.tr;
      } else if (daysDifference >= 2 && daysDifference <= 7) {
        return 'days_ago'.tr;
      } else {
        return DateFormat('MM/dd/yyyy').format(parsedDate);
      }
    } catch (e) {
      return 'invalid_date'.tr;
    }
  }

  static String getLocalTimeWithAMPM(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) return 'Invalid Date';
    try {
      return DateFormat('hh:mm a ').format(isoStringToLocalDate(dateTime));
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
