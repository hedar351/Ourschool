// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Counselor_studentFullProfileModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounselorStudentFullProfileModelAdapter
    extends TypeAdapter<CounselorStudentFullProfileModel> {
  @override
  final int typeId = 6;

  @override
  CounselorStudentFullProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CounselorStudentFullProfileModel(
      message: fields[0] as String?,
      student: fields[1] as Studentmodel?,
      subjects: (fields[2] as List?)?.cast<CounselorSubjectModel>(),
      marks: (fields[3] as List?)?.cast<CounselorMarkModel>(),
      warnings: (fields[4] as List?)?.cast<CounselorWarningModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CounselorStudentFullProfileModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.student)
      ..writeByte(2)
      ..write(obj.subjects)
      ..writeByte(3)
      ..write(obj.marks)
      ..writeByte(4)
      ..write(obj.warnings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounselorStudentFullProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
