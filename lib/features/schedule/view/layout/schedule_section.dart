import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medications/features/schedule/model/schedule/schedule.dart';
import 'package:medications/features/schedule/view/widget/schedule_widget.dart';

class ScheduleSection extends StatelessWidget {
  final String title;
  final List<ScheduleWidget> scheduleWidgets;

  const ScheduleSection({
    super.key,
    required this.title,
    required this.scheduleWidgets,
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
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: scheduleWidgets.length,
          itemBuilder: (context, index) => scheduleWidgets[index],
          separatorBuilder: (context, index) => SizedBox(height: 8.h),
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
