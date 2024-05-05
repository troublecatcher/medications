import 'package:hive/hive.dart';
import 'package:template/features/medications/model/measure/measure.dart';

part 'medication.g.dart';

@HiveType(typeId: 1)
class Medication {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final Measure measure;

  @HiveField(2)
  final int iconIndex;

  @HiveField(3)
  final String? comment;

  Medication({
    required this.name,
    required this.measure,
    required this.iconIndex,
    this.comment,
  });

  Medication copyWith({
    String? name,
    Measure? measure,
    int? iconIndex,
    String? comment,
  }) {
    return Medication(
      name: name ?? this.name,
      measure: measure ?? this.measure,
      iconIndex: iconIndex ?? this.iconIndex,
      comment: comment ?? this.comment,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Medication &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          measure == other.measure &&
          iconIndex == other.iconIndex &&
          comment == other.comment;

  @override
  int get hashCode =>
      name.hashCode ^ measure.hashCode ^ iconIndex.hashCode ^ comment.hashCode;
}
