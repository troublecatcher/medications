import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/features/medications/controller/medication_list_cubit.dart';
import 'package:template/features/medications/model/medication/medication.dart';
import 'package:template/features/schedule/controller/delete_schedule.dart';
import 'package:template/features/schedule/controller/schedule_list_cubit.dart';

Future<void> deleteMedication(
    BuildContext context, Medication medication) async {
  final medicationCubit = context.read<MedicationListCubit>();
  final scheduleCubit = context.read<ScheduleListCubit>();
  medicationCubit.delete(medicationCubit.state.indexOf(medication));
  for (final schedule in scheduleCubit.state) {
    if (schedule.medication == medication) {
      deleteSchedule(context, schedule);
    }
  }
}
