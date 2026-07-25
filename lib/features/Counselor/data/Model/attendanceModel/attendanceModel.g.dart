// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendanceModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AttendancemodelAdapter extends TypeAdapter<Attendancemodel> {
  @override
  final int typeId = 19;

  @override
  Attendancemodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Attendancemodel(
      date: fields[0] as String?,
      status: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Attendancemodel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AttendancemodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
