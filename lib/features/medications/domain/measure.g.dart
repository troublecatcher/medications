// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measure.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeasureAdapter extends TypeAdapter<Measure> {
  @override
  final int typeId = 0;

  @override
  Measure read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Measure.tablets;
      case 1:
        return Measure.syrup;
      case 2:
        return Measure.capsule;
      case 3:
        return Measure.injection;
      default:
        return Measure.tablets;
    }
  }

  @override
  void write(BinaryWriter writer, Measure obj) {
    switch (obj) {
      case Measure.tablets:
        writer.writeByte(0);
        break;
      case Measure.syrup:
        writer.writeByte(1);
        break;
      case Measure.capsule:
        writer.writeByte(2);
        break;
      case Measure.injection:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasureAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
