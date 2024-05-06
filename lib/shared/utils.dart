import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int serializeTimeOfDay(TimeOfDay timeOfDay) {
  return timeOfDay.hour * 60 + timeOfDay.minute;
}

TimeOfDay deserializeTimeOfDay(int minutesSinceMidnight) {
  final hours = minutesSinceMidnight ~/ 60;
  final minutes = minutesSinceMidnight % 60;
  return TimeOfDay(hour: hours, minute: minutes);
}

String formatTimeOfDay(TimeOfDay timeOfDay, String locale) {
  final minute = '${timeOfDay.minute}'.padLeft(2, '0');
  if (locale == 'ru') {
    final hour = timeOfDay.hour;
    return '$hour:$minute';
  } else {
    final hour = timeOfDay.hourOfPeriod;
    final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

String formatDate(DateTime dateTime, String locale) {
  if (locale == 'ru') {
    return DateFormat('d MMM, yyyy').format(dateTime);
  } else {
    return DateFormat('MMM d, yyyy').format(dateTime);
  }
}

String formatDateWithWeekday(DateTime dateTime, String locale) {
  if (locale == 'ru') {
    return DateFormat('EEEE, d MMM').format(dateTime);
  } else {
    return DateFormat('EEEE, MMM d').format(dateTime);
  }
}
