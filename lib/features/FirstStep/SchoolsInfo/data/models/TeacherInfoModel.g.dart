// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeacherInfoModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeacherInfoModelAdapter extends TypeAdapter<TeacherInfoModel> {
  @override
  final int typeId = 16;

  @override
  TeacherInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeacherInfoModel(
      employeeId: fields[0] as int?,
      name: fields[1] as String?,
      phone: fields[2] as String?,
      sections: (fields[3] as List?)?.cast<SectionsModel>(),
      subjects: (fields[4] as List?)?.cast<SubjectsModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TeacherInfoModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.employeeId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.sections)
      ..writeByte(4)
      ..write(obj.subjects);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
