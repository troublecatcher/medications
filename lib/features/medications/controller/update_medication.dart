import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:medications/features/medications/controller/medication_list_cubit.dart';
import 'package:medications/features/medications/model/medication/medication.dart';
import 'package:medications/features/medications/view/sheet/medication_bottom_sheet.dart';
import 'package:medications/features/schedule/controller/schedule_list_cubit.dart';

Future<void> updateMedication(
    BuildContext context, Medication medication) async {
  Medication? newMedication = await showCupertinoModalBottomSheet(
    enableDrag: false,
    expand: true,
    context: context,
    builder: (context) => MedicationBottomSheet(medication: medication),
  );
  if (newMedication != null && newMedication != medication) {
    final cubit = context.read<MedicationListCubit>();
    final medicationIndex = cubit.state.indexOf(medication);
    cubit.update(medicationIndex, newMedication);
    final schedules = context.read<ScheduleListCubit>().state;
    for (var i = 0; i < schedules.length; i++) {
      final schedule = schedules[i];
      if (schedule.medication == medication) {
        context
            .read<ScheduleListCubit>()
            .update(i, schedule.copyWith(medication: newMedication));
      }
    }
  }
}
