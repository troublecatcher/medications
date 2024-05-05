import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';
import 'package:template/features/schedule/view/widget/schedule_widget.dart';

class ScheduleSection extends StatelessWidget {
  final String title;
  final Map<TimeOfDay, Schedule> schedules;

  const ScheduleSection({
    super.key,
    required this.title,
    required this.schedules,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            title,
            style: CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  color: CupertinoColors.systemGrey,
                ),
          ),
        ),
        SizedBox(height: 8.h),
        ...schedules.entries.map((entry) {
          final timeOfDay = entry.key;
          final schedule = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: ScheduleWidget(
              schedule: schedule,
              timeOfDay: timeOfDay,
            ),
          );
        }).toList(),
      ],
    );
  }
}
