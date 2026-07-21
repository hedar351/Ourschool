// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeacherModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeacherModelAdapter extends TypeAdapter<TeacherModel> {
  @override
  final int typeId = 11;

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  @override
  TeacherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeacherModel(
      id: fields[0] as int?,
      localEmployeeNumber: fields[1] as int?,
      name: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TeacherModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.localEmployeeNumber)
      ..writeByte(2)
      ..write(obj.name);
  }
}
