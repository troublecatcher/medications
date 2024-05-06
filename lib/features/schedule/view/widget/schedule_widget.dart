import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:medications/app/service/notification_manager.dart';
import 'package:medications/features/schedule/controller/delete_schedule.dart';
import 'package:medications/features/schedule/model/reminder/reminder.dart';
import 'package:medications/features/schedule/model/schedule/schedule.dart';
import 'package:medications/features/schedule/view/layout/schedule_bottom_sheet.dart';
import 'package:medications/features/schedule/controller/schedule_list_cubit.dart';
import 'package:medications/features/settings/locale_cubit.dart';
import 'package:medications/generated/l10n.dart';
import 'package:medications/shared/dismissible_bin.dart';
import 'package:medications/shared/utils.dart';

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
    final cubit = context.read<ScheduleListCubit>();
    final title = S.of(context).reminder;
    final body =
        S.of(context).dontForgetToTakeMedicationname(schedule.medication.name);
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
          child: BlocBuilder<LocaleCubit, String>(
            builder: (context, state) {
              return CupertinoListTile.notched(
                additionalInfo: Text(
                  formatTimeOfDay(timeOfDay, state),
                  style: theme.textTheme.textStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
                onTap: () async {
                  Schedule? newSchedule = await showCupertinoModalBottomSheet(
                    enableDrag: false,
                    expand: true,
                    context: context,
                    builder: (context) =>
                        ScheduleBottomSheet(schedule: schedule),
                  );
                  if (newSchedule != null) {
                    final index = cubit.state.indexOf(schedule);
                    cubit.update(index, newSchedule);
                    GetIt.I<NotificationManager>().cancel(schedule);
                    if (newSchedule.reminder != Reminder.no) {
                      if (newSchedule.endDate != null) {
                        GetIt.I<NotificationManager>().schedule(
                          newSchedule,
                          title,
                          body,
                        );
                      } else {
                        GetIt.I<NotificationManager>().scheduleRecurring(
                          newSchedule,
                          title,
                          body,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
