// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReminderAdapter extends TypeAdapter<Reminder> {
  @override
  final int typeId = 2;

  @override
  Reminder read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Reminder.no;
      case 1:
        return Reminder.thisInstant;
      case 2:
        return Reminder.min5;
      case 3:
        return Reminder.min15;
      case 4:
        return Reminder.min30;
      case 5:
        return Reminder.hour1;
      default:
        return Reminder.no;
    }
  }

  @override
  void write(BinaryWriter writer, Reminder obj) {
    switch (obj) {
      case Reminder.no:
        writer.writeByte(0);
        break;
      case Reminder.thisInstant:
        writer.writeByte(1);
        break;
      case Reminder.min5:
        writer.writeByte(2);
        break;
      case Reminder.min15:
        writer.writeByte(3);
        break;
      case Reminder.min30:
        writer.writeByte(4);
        break;
      case Reminder.hour1:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
