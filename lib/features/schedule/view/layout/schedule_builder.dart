import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medications/features/schedule/controller/schedule_list_cubit.dart';
import 'package:medications/features/schedule/model/schedule/schedule.dart';
import 'package:medications/features/schedule/view/widget/no_schedule_widget.dart';
import 'package:medications/features/schedule/view/layout/schedule_section.dart';
import 'package:medications/features/schedule/view/widget/schedule_widget.dart';
import 'package:medications/generated/l10n.dart';
import 'package:medications/shared/utils.dart';

class ScheduleBuilder extends StatelessWidget {
  const ScheduleBuilder({
    super.key,
    required this.selection,
  });

  final int selection;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleListCubit, List<Schedule>>(
      builder: (context, state) {
        final now = DateTime.now();
        final selectedDate = DateTime(
          now.year,
          now.month,
          now.day,
        ).add(Duration(days: selection));
        final selectedSchedules = state.where((schedule) {
          if (schedule.endDate != null) {
            return (schedule.startDate.isAtSameMomentAs(selectedDate) ||
                    schedule.startDate.isBefore(selectedDate)) &&
                (schedule.endDate!.isAfter(selectedDate) ||
                    schedule.endDate!.isAtSameMomentAs(selectedDate));
          } else {
            return schedule.startDate.isAtSameMomentAs(selectedDate) ||
                schedule.startDate.isBefore(selectedDate);
          }
        }).toList();

        if (selectedSchedules.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: NoScheduleWidget(),
          );
        } else {
          List<ScheduleWidget> morning = [], day = [], evening = [], night = [];
          for (var schedule in selectedSchedules) {
            for (var intakeTime in schedule.intakeTimesInMinutes) {
              final timeOfDay = deserializeTimeOfDay(intakeTime);
              if (timeOfDay.hour >= 5 && timeOfDay.hour < 12) {
                morning.add(
                    ScheduleWidget(schedule: schedule, timeOfDay: timeOfDay));
              }
              if (timeOfDay.hour >= 12 && timeOfDay.hour < 17) {
                day.add(
                    ScheduleWidget(schedule: schedule, timeOfDay: timeOfDay));
              }
              if (timeOfDay.hour >= 17 && timeOfDay.hour < 21) {
                evening.add(
                    ScheduleWidget(schedule: schedule, timeOfDay: timeOfDay));
              }
              if (timeOfDay.hour >= 21 || timeOfDay.hour < 5) {
                night.add(
                    ScheduleWidget(schedule: schedule, timeOfDay: timeOfDay));
              }
            }
          }
          return SliverList(
            delegate: SliverChildListDelegate([
              if (morning.isNotEmpty)
                ScheduleSection(
                  title: S.of(context).morning,
                  scheduleWidgets: morning,
                ),
              if (day.isNotEmpty)
                ScheduleSection(
                  title: S.of(context).day,
                  scheduleWidgets: day,
                ),
              if (evening.isNotEmpty)
                ScheduleSection(
                  title: S.of(context).evening,
                  scheduleWidgets: evening,
                ),
              if (night.isNotEmpty)
                ScheduleSection(
                  title: S.of(context).night,
                  scheduleWidgets: night,
                ),
            ]),
          );
        }
      },
    );
  }
}
