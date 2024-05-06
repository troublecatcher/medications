import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/features/medications/controller/medication_list_cubit.dart';
import 'package:template/features/medications/model/medication/medication.dart';
import 'package:template/features/schedule/controller/delete_schedule.dart';
import 'package:template/features/schedule/controller/schedule_list_cubit.dart';

Future<void> deleteMedication(
    BuildContext context, Medication medication) async {
  final medicationCubit = context.read<MedicationListCubit>();
  final schedules = context.read<ScheduleListCubit>().state;
  medicationCubit.delete(medicationCubit.state.indexOf(medication));
  for (var i = schedules.length - 1; i >= 0; i--) {
    if (schedules[i].medication == medication) {
      deleteSchedule(context, schedules[i]);
    }
  }
}
