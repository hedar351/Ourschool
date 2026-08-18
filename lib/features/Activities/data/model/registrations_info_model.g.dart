// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrations_info_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegistrationsInfoModelAdapter
    extends TypeAdapter<RegistrationsInfoModel> {
  @override
  final int typeId = 41;

  @override
  RegistrationsInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegistrationsInfoModel(
      studentLocalNumber: fields[0] as int?,
      studentName: fields[1] as String?,
      sectionName: fields[2] as String?,
      gradeName: fields[3] as String?,
      status: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, RegistrationsInfoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.studentLocalNumber)
      ..writeByte(1)
      ..write(obj.studentName)
      ..writeByte(2)
      ..write(obj.sectionName)
      ..writeByte(3)
      ..write(obj.gradeName)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegistrationsInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
