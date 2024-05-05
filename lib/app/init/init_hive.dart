import 'package:hive_flutter/hive_flutter.dart';
import 'package:template/app/main.dart';
import 'package:template/features/medications/model/measure/measure.dart';
import 'package:template/features/medications/model/medication/medication.dart';
import 'package:template/features/schedule/model/reminder/reminder.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(MeasureAdapter());
  Hive.registerAdapter(MedicationAdapter());
  Hive.registerAdapter(ReminderAdapter());
  Hive.registerAdapter(ScheduleAdapter());
  medicationBox = await Hive.openBox('medications');
  scheduleBox = await Hive.openBox('schedule');
}
