import 'package:hive/hive.dart';
import 'package:template/features/medications/model/measure/measure.dart';
import 'package:template/features/medications/model/medication/medication.dart';
import 'package:template/features/schedule/model/reminder/reminder.dart';

part 'schedule.g.dart';

@HiveType(typeId: 3)
class Schedule {
  @HiveField(0)
  final Medication medication;
  @HiveField(1)
  final num amount;
  @HiveField(2)
  final Measure measure;
  @HiveField(3)
  final DateTime startDate;
  @HiveField(4)
  final DateTime? endDate;
  @HiveField(5)
  final List<int> intakeTimesInMinutes;
  @HiveField(6)
  final Reminder reminder;
  @HiveField(7)
  final int id;

  Schedule({
    required this.medication,
    required this.amount,
    required this.measure,
    required this.startDate,
    required this.endDate,
    required this.intakeTimesInMinutes,
    required this.reminder,
    required this.id,
  });

  Schedule copyWith({
    Medication? medication,
    double? amount,
    Measure? measure,
    DateTime? startDate,
    DateTime? endDate,
    List<int>? intakeTimesInMinutes,
    Reminder? reminder,
    int? id,
  }) {
    return Schedule(
      medication: medication ?? this.medication,
      amount: amount ?? this.amount,
      measure: measure ?? this.measure,
      startDate: startDate ?? this.startDate,
      endDate: startDate ?? this.endDate,
      intakeTimesInMinutes: intakeTimesInMinutes ?? this.intakeTimesInMinutes,
      reminder: reminder ?? this.reminder,
      id: id ?? this.id,
    );
  }
}
