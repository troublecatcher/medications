import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:template/app/service/notification_manager.dart';
import 'package:template/features/schedule/controller/schedule_list_cubit.dart';
import 'package:template/features/schedule/model/schedule/schedule.dart';

deleteSchedule(BuildContext context, Schedule schedule) {
  final cubit = context.read<ScheduleListCubit>();
  final index = cubit.state.indexOf(schedule);
  GetIt.I<NotificationManager>().cancel(schedule);
  cubit.delete(index);
}
