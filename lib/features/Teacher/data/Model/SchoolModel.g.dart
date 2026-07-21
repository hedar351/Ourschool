// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SchoolModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchoolsModelAdapter extends TypeAdapter<SchoolsModel> {
  @override
  final int typeId = 12;

  @override
  SchoolsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolsModel(
      schoolId: fields[0] as int?,
      schoolName: fields[1] as String?,
      subjects: (fields[2] as List?)?.cast<SubjectModel>(),
      localEmployeeNumber: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SchoolsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.schoolId)
      ..writeByte(1)
      ..write(obj.schoolName)
      ..writeByte(2)
      ..write(obj.subjects)
      ..writeByte(3)
      ..write(obj.localEmployeeNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
