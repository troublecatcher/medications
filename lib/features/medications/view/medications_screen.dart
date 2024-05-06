import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:template/features/medications/model/medication/medication.dart';
import 'package:template/features/medications/controller/medication_list_cubit.dart';
import 'package:template/features/medications/view/layout/active_medications.dart';
import 'package:template/features/medications/view/layout/all_medications.dart';
import 'package:template/features/medications/view/layout/completed_medications.dart';
import 'package:template/features/medications/view/sheet/medication_bottom_sheet.dart';
import 'package:template/features/schedule/controller/schedule_list_cubit.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/shared/base_screen.dart';

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});

  @override
  State<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  late PageController pageController;
  int page = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return BaseScreen(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            transitionBetweenRoutes: false,
            largeTitle: Text(S.of(context).medications),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Text(S.of(context).add),
              onPressed: () async {
                Medication? medication = await showCupertinoModalBottomSheet(
                  enableDrag: false,
                  expand: true,
                  context: context,
                  builder: (context) => const MedicationBottomSheet(),
                );
                if (medication != null) {
                  context.read<MedicationListCubit>().create(medication);
                }
              },
            ),
            border: null,
            stretch: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: CustomSlidingSegmentedControl(
                isStretch: true,
                innerPadding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: theme.primaryContrastingColor,
                ),
                thumbDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: theme.primaryColor,
                ),
                initialValue: page,
                children: {
                  0: FittedBox(
                    child: Text(
                      S.of(context).all,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: page == 0
                            ? Colors.white
                            : theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ),
                  1: FittedBox(
                    child: Text(
                      S.of(context).active,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: page == 1
                            ? Colors.white
                            : theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ),
                  2: FittedBox(
                    child: Text(
                      S.of(context).completed,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: page == 2
                            ? Colors.white
                            : theme.brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                      ),
                    ),
                  ),
                },
                onValueChanged: (newValue) {
                  setState(() {
                    page = newValue;
                    pageController.jumpToPage(
                      page,
                    );
                  });
                },
              ),
            ),
          ),
          BlocBuilder<ScheduleListCubit, List<Schedule>>(
            builder: (context, scheduleList) =>
                BlocBuilder<MedicationListCubit, List<Medication>>(
                    builder: (context, medicationList) {
              final List<Medication> scheduledMedications =
                  scheduleList.map((e) => e.medication).toList();

              final List<Medication> activeList = medicationList
                  .where((element) => scheduledMedications.contains(element))
                  .toList();
              final List<Medication> completedList = medicationList
                  .where((element) => !scheduledMedications.contains(element))
                  .toList();
              return SliverFillRemaining(
                child: PageView(
                  onPageChanged: (value) => setState(() => page = value),
                  controller: pageController,
                  children: [
                    AllMedications(
                      activeList: activeList,
                      completedList: completedList,
                      fullList: medicationList,
                    ),
                    ActiveMedications(activeList: activeList),
                    CompletedMedications(completedList: completedList),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
