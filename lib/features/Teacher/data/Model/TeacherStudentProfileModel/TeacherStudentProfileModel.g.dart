// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TeacherStudentProfileModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeacherStudentProfileModelAdapter
    extends TypeAdapter<TeacherStudentProfileModel> {
  @override
  final int typeId = 20;

  @override
  TeacherStudentProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TeacherStudentProfileModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      localStudentNumber: fields[2] as int?,
      guardianName: fields[3] as String?,
      guardianPhone: fields[4] as String?,
      semester1Marks: (fields[5] as List?)?.cast<SemesterMarksModel>(),
      semester2Marks: (fields[6] as List?)?.cast<SemesterMarksModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TeacherStudentProfileModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.localStudentNumber)
      ..writeByte(3)
      ..write(obj.guardianName)
      ..writeByte(4)
      ..write(obj.guardianPhone)
      ..writeByte(5)
      ..write(obj.semester1Marks)
      ..writeByte(6)
      ..write(obj.semester2Marks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherStudentProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
