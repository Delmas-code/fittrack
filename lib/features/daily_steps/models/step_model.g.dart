// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StepLogAdapter extends TypeAdapter<StepLog> {
  @override
  final int typeId = 1;

  @override
  StepLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StepLog(
      dateId: fields[0] as String,
      count: fields[1] as int,
      target: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, StepLog obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dateId)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.target);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
