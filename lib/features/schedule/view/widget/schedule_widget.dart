import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:template/app/service/notification_manager.dart';
import 'package:template/features/schedule/controller/delete_schedule.dart';
import 'package:template/features/schedule/model/reminder/reminder.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';
import 'package:template/features/schedule/view/layout/schedule_bottom_sheet.dart';
import 'package:template/features/schedule/controller/schedule_list_cubit.dart';
import 'package:template/features/settings/locale_cubit.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/shared/dismissible_bin.dart';
import 'package:template/shared/utils.dart';

class ScheduleWidget extends StatelessWidget {
  final Schedule schedule;
  final TimeOfDay timeOfDay;

  const ScheduleWidget({
    super.key,
    required this.schedule,
    required this.timeOfDay,
  });

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final medication = schedule.medication;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        background: const DismissibleBin(),
        onDismissed: (direction) => deleteSchedule(context, schedule),
        key: UniqueKey(),
        child: Container(
          decoration: BoxDecoration(
            color: theme.primaryContrastingColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CupertinoListTile.notched(
            additionalInfo: Text(
              formatTimeOfDay(timeOfDay),
              style: theme.textTheme.textStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),
            onTap: () async {
              Schedule? newSchedule = await showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                builder: (context) => ScheduleBottomSheet(schedule: schedule),
              );
              if (newSchedule != null) {
                final index =
                    context.read<ScheduleListCubit>().state.indexOf(schedule);
                context.read<ScheduleListCubit>().update(index, newSchedule);
                GetIt.I<NotificationManager>().cancel(schedule);
                if (newSchedule.reminder != Reminder.no) {
                  if (newSchedule.endDate != null) {
                    GetIt.I<NotificationManager>().schedule(
                      newSchedule,
                      S.of(context).reminder,
                      S.of(context).dontForgetToTakeMedicationname(
                          schedule.medication.name),
                    );
                  } else {
                    GetIt.I<NotificationManager>().scheduleRecurring(
                      newSchedule,
                      S.of(context).reminder,
                      S.of(context).dontForgetToTakeMedicationname(
                          schedule.medication.name),
                    );
                  }
                }
              }
            },
            leadingSize: 60,
            leading: Image.asset(
              'assets/imgs/${medication.iconIndex}.png',
              width: 42.r,
              height: 42.r,
            ),
            title: Text(medication.name),
            subtitle: BlocBuilder<LocaleCubit, String>(
              builder: (context, state) {
                return Text(
                    '${schedule.amount} ${state == 'ru' ? schedule.measure.titleRU : schedule.measure.titleEN}');
              },
            ),
            trailing: const CupertinoListTileChevron(),
          ),
        ),
      ),
    );
  }
}
