import 'package:hive/hive.dart';

part 'measure.g.dart';

@HiveType(typeId: 0)
enum Measure {
  @HiveField(0)
  pills('Pills', 'Таблетки'),
  @HiveField(1)
  syrup('Syrup', 'Сироп'),
  @HiveField(2)
  capsule('Capsule', 'Капсулы'),
  @HiveField(3)
  injection('Injection', 'Инъекция'),
  @HiveField(4)
  piece('Piece', 'Штука'),
  @HiveField(5)
  mg('mg', 'мг');

  final String titleEN;
  final String titleRU;

  const Measure(this.titleEN, this.titleRU);
}
