import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:template/features/medications/controller/delete_medication.dart';
import 'package:template/features/medications/model/measure/measure.dart';
import 'package:template/features/medications/model/medication/medication.dart';
import 'package:template/features/medications/view/sheet/collection_action_sheet.dart';
import 'package:template/features/settings/locale_cubit.dart';
import 'package:template/generated/l10n.dart';
import 'package:template/shared/base_screen.dart';

class MedicationBottomSheet extends StatefulWidget {
  final Medication? medication;
  const MedicationBottomSheet({super.key, this.medication});

  @override
  State<MedicationBottomSheet> createState() => _MedicationBottomSheetState();
}

class _MedicationBottomSheetState extends State<MedicationBottomSheet> {
  late TextEditingController nameController;
  int measureIndex = 0;
  int? iconIndex;
  late TextEditingController commentController;
  String title = '';
  String buttonTitle = '';

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    commentController = TextEditingController();
    final medication = widget.medication;
    if (medication != null) {
      nameController.text = medication.name;
      measureIndex = medication.measure.index;
      iconIndex = medication.iconIndex;
      if (medication.comment != null) {
        commentController.text = medication.comment!;
      }
    }
  }

  @override
  void didChangeDependencies() {
    title = S.of(context).addMedication;
    buttonTitle = S.of(context).add;
    if (widget.medication != null) {
      title = S.of(context).changeMedication;
      buttonTitle = S.of(context).done;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    nameController.dispose();
    commentController.dispose();
    super.dispose();
  }

  bool formValid() {
    return nameController.text.isNotEmpty && iconIndex != null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = CupertinoTheme.of(context);
    return BaseScreen(
      backgroundColor: theme.brightness == Brightness.dark
          ? theme.primaryContrastingColor
          : theme.scaffoldBackgroundColor,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: theme.brightness == Brightness.dark
            ? theme.primaryContrastingColor
            : theme.scaffoldBackgroundColor,
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text(S.of(context).close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: formValid()
              ? () => Navigator.of(context).pop(
                    Medication(
                      name: nameController.text,
                      measure: Measure.values[measureIndex],
                      iconIndex: iconIndex!,
                      comment: commentController.text.isNotEmpty
                          ? commentController.text
                          : null,
                    ),
                  )
              : null,
          child: Text(buttonTitle),
        ),
        border: null,
        middle: Text(title),
      ),
      child: Material(
        color: Colors.transparent,
        child: SingleChildScrollView(
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
                      placeholder: S.of(context).medicationName,
                      controller: nameController,
                      onChanged: (value) => setState(() {}),
                    ),
                  ),
                  CupertinoListTile(
                    onTap: () async {
                      final newMeasure = await showCupertinoModalPopup(
                        context: context,
                        builder: (context) => CollectionActionSheet(
                          currentIndex: measureIndex,
                          enumCollection: Measure.values,
                        ),
                      );
                      if (newMeasure != null) {
                        setState(() {
                          measureIndex = newMeasure;
                        });
                      }
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(S.of(context).releaseForm),
                        Row(
                          children: [
                            BlocBuilder<LocaleCubit, String>(
                              builder: (context, state) {
                                return Text(
                                  toBeginningOfSentenceCase(state == 'ru'
                                      ? Measure.values[measureIndex].titleRU
                                      : Measure.values[measureIndex].titleEN)!,
                                  style: TextStyle(color: theme.primaryColor),
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            const Icon(CupertinoIcons.chevron_up_chevron_down),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                    Row(children: [
                      const SizedBox(width: 16),
                      Text(
                        S.of(context).icon,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: CupertinoColors.systemGrey,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    CupertinoListSection.insetGrouped(
                      margin: EdgeInsets.zero,
                      children: [
                        GridView.count(
                          mainAxisSpacing: 8.r,
                          crossAxisSpacing: 8.r,
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 11.h),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 5,
                          children: List.generate(
                            10,
                            (index) => GestureDetector(
                              onTap: () {
                                setState(() => iconIndex = index);
                              },
                              child: Container(
                                padding: EdgeInsets.all(6.r),
                                decoration: BoxDecoration(
                                  color: theme.primaryContrastingColor,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: iconIndex == index
                                      ? Border.all(
                                          width: 2,
                                          color: theme.primaryColor,
                                        )
                                      : Border.all(
                                          width: 2,
                                          color: Colors.transparent,
                                        ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.15),
                                      blurRadius: 8,
                                    )
                                  ],
                                ),
                                child: Image.asset(
                                  'assets/imgs/$index.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              CupertinoListSection.insetGrouped(
                children: [
                  CupertinoTextField.borderless(
                    maxLines: 8,
                    controller: commentController,
                    placeholder: S.of(context).comment,
                  )
                ],
              ),
              const SizedBox(height: 32),
              if (widget.medication != null)
                CupertinoButton(
                  child: Text(S.of(context).deleteMedication),
                  onPressed: () {
                    deleteMedication(context, widget.medication!);
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
