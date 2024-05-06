import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:template/app/service/notification_manager.dart';
import 'package:template/features/medications/model/measure/measure.dart';
import 'package:template/features/medications/model/medication/medication.dart';
import 'package:template/features/medications/view/widget/no_medication_widget.dart';
import 'package:template/features/schedule/model/reminder/reminder.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';
import 'package:template/features/medications/controller/medication_list_cubit.dart';
import 'package:template/features/medications/view/widget/medication_widget.dart';
import 'package:template/features/medications/view/sheet/collection_action_sheet.dart';
import 'package:template/features/schedule/view/layout/intake_time_bottom_sheet.dart';
import 'package:template/features/settings/locale_cubit.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/shared/base_screen.dart';
import 'package:template/shared/dismissible_bin.dart';
import 'package:template/shared/utils.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final Schedule? schedule;
  const ScheduleBottomSheet({super.key, this.schedule});

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  late PageController pageController;
  late TextEditingController amountController;
  int page = 0;
  Medication? currentMedication;
  int measure = 0;
  late DateTime startDate;
  late DateTime endDate;
  bool doesNotEnd = false;
  Set<int> intakeTimes = {};
  int reminderIndex = 1;

  bool startsExpanded = false;
  bool endsExpanded = false;
  String title = '';
  String buttonTitle = '';

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    startDate = DateTime(now.year, now.month, now.day);
    endDate = DateTime(now.year, now.month, now.day);
    pageController = PageController();
    amountController = TextEditingController();
    final schedule = widget.schedule;
    if (schedule != null) {
      amountController.text = schedule.amount.toString();
      currentMedication = schedule.medication;
      measure = schedule.measure.index;
      startDate = schedule.startDate;
      if (schedule.endDate == null) {
        doesNotEnd = true;
      } else {
        endDate = schedule.endDate!;
      }
      intakeTimes = schedule.intakeTimesInMinutes.toSet();
      reminderIndex = schedule.reminder.index;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    title = S.of(context).addSchedule;
    buttonTitle = S.of(context).add;
    if (widget.schedule != null) {
      title = S.of(context).changeSchedule;
      buttonTitle = S.of(context).done;
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    amountController.dispose();
    super.dispose();
  }

  bool formValid() {
    final amount = amountController.text;
    bool additionalCondition = true;
    if (!doesNotEnd) {
      if (endDate.isBefore(startDate)) {
        additionalCondition = false;
      }
    }
    return amount.isNotEmpty &&
        (int.tryParse(amount) != null || double.tryParse(amount) != null) &&
        intakeTimes.isNotEmpty &&
        additionalCondition;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    final locale = context.read<LocaleCubit>().state;
    return BaseScreen(
      bottom: false,
      backgroundColor: theme.brightness == Brightness.dark
          ? theme.primaryContrastingColor
          : theme.scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: theme.brightness == Brightness.dark
            ? theme.primaryContrastingColor
            : theme.scaffoldBackgroundColor,
        leading: Builder(builder: (context) {
          if (page == 0) {
            return CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(S.of(context).close),
              onPressed: () => Navigator.of(context).pop(),
            );
          } else {
            return CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(S.of(context).back),
              onPressed: () {
                setState(() {
                  currentMedication = null;
                  pageController.animateToPage(
                    --page,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.decelerate,
                  );
                });
              },
            );
          }
        }),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: formValid()
              ? () async => Navigator.of(context).pop(
                    Schedule(
                      medication: currentMedication!,
                      amount: num.parse(amountController.text),
                      measure: Measure.values[measure],
                      startDate: startDate,
                      endDate: doesNotEnd ? null : endDate,
                      intakeTimesInMinutes: intakeTimes.toList(),
                      reminder: Reminder.values[reminderIndex],
                      id: await GetIt.I<NotificationManager>().genId(),
                    ),
                  )
              : null,
          child: Text(buttonTitle),
        ),
        border: null,
        middle: Text(title),
      ),
      child: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          if (widget.schedule == null)
            BlocBuilder<MedicationListCubit, List<Medication>>(
              builder: (context, state) {
                if (state.isNotEmpty) {
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 37),
                    itemBuilder: (context, index) {
                      final medication = state[index];
                      return MedicationWidget(
                        index: index,
                        medication: medication,
                        onTap: () {
                          setState(() {
                            currentMedication = medication;
                            pageController.animateToPage(
                              ++page,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.decelerate,
                            );
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 8.h),
                    itemCount: state.length,
                  );
                } else {
                  return Material(
                      color: Colors.transparent,
                      child: NoMedicationWidget(title: S.of(context).added));
                }
              },
            ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 37),
                CupertinoListSection.insetGrouped(
                  hasLeading: false,
                  children: [
                    CupertinoListTile(
                      title: CupertinoTextField.borderless(
                        style: theme.textTheme.navTitleTextStyle.copyWith(
                          fontSize: 17.sp,
                          color: theme.textTheme.textStyle.color,
                        ),
                        padding: EdgeInsets.zero,
                        placeholder: S.of(context).amount,
                        controller: amountController,
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    CupertinoListTile(
                      onTap: () async {
                        final newMeasure = await showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CollectionActionSheet(
                            currentIndex: measure,
                            enumCollection: Measure.values,
                          ),
                        );
                        if (newMeasure != null) {
                          setState(() {
                            measure = newMeasure;
                          });
                        }
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).measure),
                          Row(
                            children: [
                              Text(
                                toBeginningOfSentenceCase(locale == 'ru'
                                    ? Measure.values[measure].titleRU
                                    : Measure.values[measure].titleEN)!,
                                style: TextStyle(color: theme.primaryColor),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                  CupertinoIcons.chevron_up_chevron_down),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                CupertinoListSection.insetGrouped(
                  hasLeading: false,
                  children: [
                    CupertinoListTile(
                      onTap: () => setState(() {
                        startsExpanded = !startsExpanded;
                        endsExpanded = false;
                      }),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).starts),
                          Text(formatDate(startDate, locale)),
                        ],
                      ),
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: startsExpanded
                          ? SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (value) =>
                                    setState(() => startDate = value),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    if (!doesNotEnd)
                      CupertinoListTile(
                        onTap: !doesNotEnd
                            ? () => setState(() {
                                  endsExpanded = !endsExpanded;
                                  startsExpanded = false;
                                })
                            : null,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(S.of(context).ends),
                            Text(formatDate(endDate, locale)),
                          ],
                        ),
                      ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: endsExpanded
                          ? SizedBox(
                              height: 250,
                              width: double.infinity,
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                onDateTimeChanged: (value) =>
                                    setState(() => endDate = value),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    CupertinoListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).doesntEnd),
                          CupertinoSwitch(
                            value: doesNotEnd,
                            onChanged: (value) => setState(() {
                              endsExpanded = false;
                              doesNotEnd = value;
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                CupertinoListSection.insetGrouped(
                  hasLeading: false,
                  children: [
                    ...List.generate(intakeTimes.length, (index) {
                      final intakeTime = intakeTimes.elementAt(index);
                      return Dismissible(
                        background: const DismissibleBin(),
                        key: UniqueKey(),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) {
                          setState(() {
                            intakeTimes.remove(intakeTime);
                          });
                        },
                        child: CupertinoListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(S.of(context).timeOfIntakeNumber(index + 1)),
                              Text(
                                formatTimeOfDay(
                                  deserializeTimeOfDay(intakeTime),
                                  locale,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    Builder(
                      builder: (context) {
                        if (intakeTimes.isEmpty) {
                          return CupertinoListTile(
                            onTap: () async => await addTimeOfDay(context),
                            title: Text(
                              S.of(context).addTimeOfIntake,
                              style: TextStyle(color: theme.primaryColor),
                            ),
                          );
                        } else {
                          return CupertinoListTile(
                            onTap: () async => await addTimeOfDay(context),
                            title: Text(
                              S.of(context).addMore,
                              style: TextStyle(color: theme.primaryColor),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                CupertinoListSection.insetGrouped(
                  hasLeading: false,
                  children: [
                    CupertinoListTile(
                      onTap: () async {
                        final newReminder = await showCupertinoModalPopup(
                          context: context,
                          builder: (context) => CollectionActionSheet(
                            currentIndex: reminderIndex,
                            enumCollection: Reminder.values,
                          ),
                        );
                        if (newReminder != null) {
                          setState(() {
                            reminderIndex = newReminder;
                          });
                        }
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(S.of(context).reminder),
                          Row(
                            children: [
                              Text(
                                toBeginningOfSentenceCase(locale == 'ru'
                                    ? Reminder.values[reminderIndex].titleRU
                                    : Reminder.values[reminderIndex].titleEN)!,
                                style: TextStyle(color: theme.primaryColor),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                CupertinoIcons.chevron_up_chevron_down,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 37),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addTimeOfDay(BuildContext context) async {
    final newIntakeTime = await showCupertinoModalPopup<TimeOfDay>(
      context: context,
      builder: (context) => const IntakeTimeBottomSheet(),
    );
    if (newIntakeTime != null) {
      setState(() {
        intakeTimes.add(serializeTimeOfDay(newIntakeTime));
      });
    }
  }
}
