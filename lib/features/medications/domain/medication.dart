import 'package:hive/hive.dart';
import 'package:template/features/medications/domain/measure.dart';

part 'medication.g.dart';

@HiveType(typeId: 1)
class Medication {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final Measure measure;

  @HiveField(2)
  final String icon;

  @HiveField(3)
  final String comment;

  Medication({
    required this.name,
    required this.measure,
    required this.icon,
    required this.comment,
  });
}
