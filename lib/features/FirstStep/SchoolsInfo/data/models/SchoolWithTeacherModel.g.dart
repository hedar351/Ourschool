// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SchoolWithTeacherModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchoolWithTeacherModelAdapter
    extends TypeAdapter<SchoolWithTeacherModel> {
  @override
  final int typeId = 18;

  @override
  SchoolWithTeacherModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolWithTeacherModel(
      message: fields[0] as String?,
      schoolInfo: (fields[1] as List?)?.cast<SchoolInfoModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SchoolWithTeacherModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.schoolInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolWithTeacherModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
