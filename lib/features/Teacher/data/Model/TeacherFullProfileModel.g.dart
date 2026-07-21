// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeacherFullProfileModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeacherFullProfileModelAdapter
    extends TypeAdapter<TeacherFullProfileModel> {
  @override
  final int typeId = 10;

  @override
  TeacherFullProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeacherFullProfileModel(
      message: fields[0] as String?,
      teacher: fields[1] as TeacherModel?,
      schools: (fields[2] as List?)?.cast<SchoolsModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TeacherFullProfileModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.teacher)
      ..writeByte(2)
      ..write(obj.schools);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherFullProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
