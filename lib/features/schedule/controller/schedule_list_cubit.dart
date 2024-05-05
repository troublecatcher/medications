import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/app/main.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';

class ScheduleListCubit extends Cubit<List<Schedule>> {
  late Timer _timer;

  ScheduleListCubit() : super([]) {
    read();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      final now = DateTime.now();
      final updatedList = List<Schedule>.from(state);
      for (int i = updatedList.length - 1; i >= 0; i--) {
        if (updatedList[i].endDate != null &&
            updatedList[i].endDate!.isBefore(now)) {
          updatedList.removeAt(i);
        }
      }
      emit(updatedList);
    });
  }

  @override
  Future<void> close() async {
    // Cancel the timer when the cubit is closed
    _timer.cancel();
    super.close();
  }

  void create(Schedule schedule) {
    scheduleBox.add(schedule).whenComplete(() {
      emit([...state, schedule]);
    });
  }

  void read() {
    List<Schedule> scheduleList = [];
    if (scheduleBox.isNotEmpty) {
      for (var i = 0; i < scheduleBox.length; i++) {
        scheduleList.add(scheduleBox.getAt(i)!);
      }
      emit(scheduleList);
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
}
