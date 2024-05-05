import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 2)
enum Reminder {
  @HiveField(0)
  no('No', 'Нет', 0),
  @HiveField(1)
  thisInstant('This instant', 'В момент', 0),
  @HiveField(2)
  min5('In 5 minutes', 'За 5 минут', 5),
  @HiveField(3)
  min15('In 15 minutes', 'За 15 минут', 15),
  @HiveField(4)
  min30('In 30 minutes', 'За 30 минут', 30),
  @HiveField(5)
  hour1('In 1 hour', 'За 1 час', 60);

  final String titleEN;
  final String titleRU;
  final int minutesToBeSubtracted;

  const Reminder(this.titleEN, this.titleRU, this.minutesToBeSubtracted);
}
