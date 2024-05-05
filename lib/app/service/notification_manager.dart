import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:template/features/schedule/model/reminder/reminder.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/shared/utils.dart';
import 'package:timezone/data/latest_all.dart' as tz1;
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin get plugin => _plugin;

  Future<void> init() async {
    const DarwinInitializationSettings initSettings =
        DarwinInitializationSettings();
    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initSettings,
    );
    await _plugin.initialize(initializationSettings);

    tz1.initializeTimeZones();
  }

  Future<void> schedule(Schedule schedule, String title, String body) async {
    for (int intakeTime in schedule.intakeTimesInMinutes) {
      final timeOfDay = deserializeTimeOfDay(intakeTime);

      DateTime currentDate = schedule.startDate
          .copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute);
      final endDate = schedule.endDate!
          .copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute + 1);

      while (currentDate.isBefore(endDate)) {
        final id = await genId();
        final neededDateTime = DateTime(
          currentDate.year,
          currentDate.month,
          currentDate.day,
          timeOfDay.hour,
          timeOfDay.minute,
        ).subtract(
          Duration(minutes: schedule.reminder.minutesToBeSubtracted),
        );
        final now = DateTime.now();
        final a = neededDateTime.isBefore(now);
        if (a) {
          print(neededDateTime);
          neededDateTime.add(const Duration(days: 1));
          print(neededDateTime);
        }
        await _plugin.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(neededDateTime, tz.local),
          const NotificationDetails(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: schedule.id.toString(),
        );
        currentDate = currentDate.add(const Duration(days: 1));
      }
    }
  }

  Future<void> scheduleRecurring(
      Schedule schedule, String title, String body) async {
    for (int intakeTime in schedule.intakeTimesInMinutes) {
      final id = await genId();
      final timeOfDay = deserializeTimeOfDay(intakeTime);
      final now = DateTime.now();
      final neededDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        timeOfDay.hour,
        timeOfDay.minute,
      ).subtract(
        Duration(minutes: schedule.reminder.minutesToBeSubtracted),
      );
      if (neededDateTime.isBefore(DateTime.now())) {
        neededDateTime.add(const Duration(days: 1));
      }
      await _plugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(neededDateTime, tz.local),
        const NotificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: schedule.id.toString(),
      );
    }
  }

  Future<void> cancel(Schedule schedule) async {
    final List<PendingNotificationRequest> b =
        await _plugin.pendingNotificationRequests();
    final neededPushes =
        b.where((element) => element.payload == schedule.id.toString());
    for (var push in neededPushes) {
      _plugin.cancel(push.id);
    }
  }

  Future<int> genId() async {
    List pending = await _plugin.pendingNotificationRequests();
    pending = pending.map((e) => e.id).toList();
    int key = UniqueKey().hashCode;
    while (pending.contains(key)) {
      key = UniqueKey().hashCode;
    }
    return key;
  }
}
