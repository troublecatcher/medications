import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:template/app/service/notification_manager.dart';
import 'package:template/features/schedule/model/reminder/reminder.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';
import 'package:template/features/schedule/view/layout/schedule_builder.dart';
import 'package:template/features/schedule/view/layout/schedule_bottom_sheet.dart';
import 'package:template/features/schedule/controller/schedule_list_cubit.dart';
import 'package:template/features/settings/locale_cubit.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/shared/base_screen.dart';
import 'package:template/shared/utils.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selection = 0;

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return BaseScreen(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            transitionBetweenRoutes: false,
            largeTitle: Text(S.of(context).schedule),
            leading: Row(
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('check'),
                  onPressed: () async {
                    final pendingNotificationRequests =
                        await GetIt.I<NotificationManager>()
                            .plugin
                            .pendingNotificationRequests();
                    for (var element in pendingNotificationRequests) {
                      print(element.id);
                    }
                  },
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: const Text('clear'),
                  onPressed: () async {
                    await GetIt.I<NotificationManager>().plugin.cancelAll();
                  },
                ),
              ],
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(S.of(context).add),
              onPressed: () async {
                Schedule? schedule = await showCupertinoModalBottomSheet(
                  enableDrag: false,
                  expand: true,
                  context: context,
                  builder: (context) => const ScheduleBottomSheet(),
                );
                if (schedule != null) {
                  context.read<ScheduleListCubit>().create(schedule);
                  if (schedule.reminder != Reminder.no) {
                    if (schedule.endDate != null) {
                      GetIt.I<NotificationManager>().schedule(
                        schedule,
                        S.of(context).reminder,
                        S.of(context).dontForgetToTakeMedicationname(
                            schedule.medication.name),
                      );
                    } else {
                      GetIt.I<NotificationManager>().scheduleRecurring(
                        schedule,
                        S.of(context).reminder,
                        S.of(context).dontForgetToTakeMedicationname(
                            schedule.medication.name),
                      );
                    }
                  }
                }
              },
            ),
            border: null,
            stretch: true,
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                  height: 56.r,
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) {
                      final now = DateTime.now();
                      final day = now.add(Duration(days: index));
                      final condition = index == selection;
                      return CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => setState(() => selection = index),
                        child: Container(
                          width: 56.r,
                          height: 56.r,
                          decoration: BoxDecoration(
                            color: condition
                                ? CupertinoTheme.of(context).primaryColor
                                : CupertinoTheme.of(context)
                                    .primaryContrastingColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: FittedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('E').format(day)[0],
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: condition
                                        ? Colors.white
                                        : CupertinoTheme.of(context)
                                                    .brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                  ),
                                ),
                                Text(
                                  day.day.toString(),
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.bold,
                                    color: condition
                                        ? Colors.white
                                        : CupertinoTheme.of(context)
                                                    .brightness ==
                                                Brightness.light
                                            ? Colors.black
                                            : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 20.w),
                    itemCount: 7,
                  )),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.only(
                top: 8.h, bottom: 16.h, right: 16.w, left: 16.w),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    selection == 0 ? S.of(context).today : S.of(context).later,
                    style: theme.textTheme.textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  BlocBuilder<LocaleCubit, String>(
                    builder: (context, state) {
                      return Text(
                        toBeginningOfSentenceCase(formatDateWithWeekday(
                            DateTime.now().add(Duration(days: selection)),
                            state))!,
                        style: theme.textTheme.textStyle.copyWith(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ScheduleBuilder(selection: selection),
        ],
      ),
    );
  }
}
