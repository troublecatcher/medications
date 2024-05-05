import 'package:flutter/material.dart';

int serializeTimeOfDay(TimeOfDay timeOfDay) {
  return timeOfDay.hour * 60 + timeOfDay.minute;
}

TimeOfDay deserializeTimeOfDay(int minutesSinceMidnight) {
  final hours = minutesSinceMidnight ~/ 60;
  final minutes = minutesSinceMidnight % 60;
  return TimeOfDay(hour: hours, minute: minutes);
}

String formatTimeOfDay(TimeOfDay timeOfDay) {
  final hour = timeOfDay.hourOfPeriod;
  final minute = '${timeOfDay.minute}'.padLeft(2, '0');
  final period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hour:$minute $period';
}
