// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Counselor_SubjectsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounselorSubjectModelAdapter extends TypeAdapter<CounselorSubjectModel> {
  @override
  final int typeId = 7;

  @override
  CounselorSubjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CounselorSubjectModel(
      subjectId: fields[0] as int?,
      subjectName: fields[1] as String?,
      teacherId: fields[2] as int?,
      teacherName: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CounselorSubjectModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.subjectId)
      ..writeByte(1)
      ..write(obj.subjectName)
      ..writeByte(2)
      ..write(obj.teacherId)
      ..writeByte(3)
      ..write(obj.teacherName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounselorSubjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
