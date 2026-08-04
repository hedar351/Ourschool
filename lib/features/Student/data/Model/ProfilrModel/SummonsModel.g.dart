// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SummonsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SummonsModelAdapter extends TypeAdapter<SummonsModel> {
  @override
  final int typeId = 24;

  @override
  SummonsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SummonsModel(
      reason: fields[0] as String?,
      date: fields[1] as String?,
      createdAt: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SummonsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.reason)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SummonsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
