import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/schedule/controller/schedule_list_cubit.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';
import 'package:template/features/schedule/view/widget/no_schedule_widget.dart';
import 'package:template/features/schedule/view/layout/schedule_section.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/shared/utils.dart';

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

        Map<TimeOfDay, Schedule> morningSchedules = {};
        for (var schedule in selectedSchedules) {
          for (var intakeTime in schedule.intakeTimesInMinutes) {
            final timeOfDay = deserializeTimeOfDay(intakeTime);
            if (timeOfDay.hour >= 5 && timeOfDay.hour < 12) {
              morningSchedules[timeOfDay] = schedule;
            }
          }
        }

        Map<TimeOfDay, Schedule> daySchedules = {};
        for (var schedule in selectedSchedules) {
          for (var intakeTime in schedule.intakeTimesInMinutes) {
            final timeOfDay = deserializeTimeOfDay(intakeTime);
            if (timeOfDay.hour >= 12 && timeOfDay.hour < 17) {
              daySchedules[timeOfDay] = schedule;
            }
          }
        }
        Map<TimeOfDay, Schedule> eveningSchedules = {};
        for (var schedule in selectedSchedules) {
          for (var intakeTime in schedule.intakeTimesInMinutes) {
            final timeOfDay = deserializeTimeOfDay(intakeTime);
            if (timeOfDay.hour >= 17 && timeOfDay.hour < 21) {
              eveningSchedules[timeOfDay] = schedule;
            }
          }
        }
        Map<TimeOfDay, Schedule> nightSchedules = {};
        for (var schedule in selectedSchedules) {
          for (var intakeTime in schedule.intakeTimesInMinutes) {
            final timeOfDay = deserializeTimeOfDay(intakeTime);
            if (timeOfDay.hour >= 21 || timeOfDay.hour < 5) {
              nightSchedules[timeOfDay] = schedule;
            }
          }
        }

        if (morningSchedules.isEmpty &&
            daySchedules.isEmpty &&
            eveningSchedules.isEmpty &&
            nightSchedules.isEmpty) {
          return const SliverFillRemaining(
            hasScrollBody: false,
            child: NoScheduleWidget(),
          );
        } else {
          return SliverList(
            delegate: SliverChildListDelegate([
              if (morningSchedules.isNotEmpty) ...[
                ScheduleSection(
                    title: S.of(context).morning, schedules: morningSchedules),
                SizedBox(height: 8.h),
              ],
              if (daySchedules.isNotEmpty) ...[
                ScheduleSection(
                    title: S.of(context).day, schedules: daySchedules),
                SizedBox(height: 8.h),
              ],
              if (eveningSchedules.isNotEmpty) ...[
                ScheduleSection(
                    title: S.of(context).evening, schedules: eveningSchedules),
                SizedBox(height: 8.h),
              ],
              if (nightSchedules.isNotEmpty) ...[
                ScheduleSection(
                    title: S.of(context).night, schedules: nightSchedules),
                SizedBox(height: 8.h),
              ],
            ]),
          );
        }
      },
    );
  }
}
