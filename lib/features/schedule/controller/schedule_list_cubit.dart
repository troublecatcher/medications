import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/app/main.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';
import 'package:template/shared/utils.dart';

class ScheduleListCubit extends Cubit<List<Schedule>> {
  ScheduleListCubit() : super([]) {
    read();
    print(state);
  }

  void create(Schedule schedule) {
    scheduleBox.add(schedule).whenComplete(() {
      emit([...state, schedule]);
    });
  }

  read() async {
    List<Schedule> scheduleList = [];
    if (scheduleBox.isNotEmpty) {
      List<int> garbageIds = [];
      for (var i = 0; i < scheduleBox.length; i++) {
        final schedule = scheduleBox.getAt(i)!;
        final endDate = schedule.endDate;
        if (endDate != null) {
          final int lastIntakeTimeInMinutes =
              schedule.intakeTimesInMinutes.reduce(max);
          final TimeOfDay lastIntakeTime = deserializeTimeOfDay(
            lastIntakeTimeInMinutes,
          );
          final DateTime lastIntake = DateTime(
            endDate.year,
            endDate.month,
            endDate.day,
            lastIntakeTime.hour,
            lastIntakeTime.minute,
          );
          if (lastIntake.isBefore(DateTime.now())) {
            garbageIds.add(i);
          }
        }
        scheduleList.add(schedule);
      }
      emit(scheduleList);
      for (final i in garbageIds) {
        delete(i);
      }
    } else {
      emit([]);
    }
  }

  void update(int index, Schedule schedule) {
    scheduleBox.putAt(index, schedule).whenComplete(() {
      final List<Schedule> updatedList = List.from(state);
      updatedList[index] = schedule;
      emit(updatedList);
    });
  }

  void delete(int index) {
    scheduleBox.deleteAt(index).whenComplete(() {
      final List<Schedule> updatedList = List.from(state);
      updatedList.removeAt(index);
      emit(updatedList);
    });
  }

  // deleteAll(List<int> indexes) {
  //   final List<Schedule> updatedList = List.from(state);
  //   for (var index in indexes) {
  //     scheduleBox.deleteAt(index);
  //     updatedList.removeAt(index);
  //   }
  //   emit(updatedList);
  // }
}
