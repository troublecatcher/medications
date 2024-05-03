import 'package:hive/hive.dart';

part 'measure.g.dart';

@HiveType(typeId: 0)
enum Measure {
  @HiveField(0)
  tablets,
  @HiveField(1)
  syrup,
  @HiveField(2)
  capsule,
  @HiveField(3)
  injection,
}
