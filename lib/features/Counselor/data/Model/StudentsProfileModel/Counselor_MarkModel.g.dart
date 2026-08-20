// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Counselor_MarkModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CounselorMarkModelAdapter extends TypeAdapter<CounselorMarkModel> {
  @override
  final int typeId = 8;

  @override
  CounselorMarkModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CounselorMarkModel(
      subjectId: fields[0] as int?,
      localSubjectId: fields[1] as int?,
      subjectName: fields[2] as String?,
      semester: fields[3] as int?,
      quiz1: fields[4] as int?,
      quiz2: fields[5] as int?,
      homework: fields[6] as int?,
      finalExam: fields[7] as int?,
      total: fields[8] as int?,
      oral: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, CounselorMarkModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.subjectId)
      ..writeByte(1)
      ..write(obj.localSubjectId)
      ..writeByte(2)
      ..write(obj.subjectName)
      ..writeByte(3)
      ..write(obj.semester)
      ..writeByte(4)
      ..write(obj.quiz1)
      ..writeByte(5)
      ..write(obj.quiz2)
      ..writeByte(6)
      ..write(obj.homework)
      ..writeByte(7)
      ..write(obj.finalExam)
      ..writeByte(8)
      ..write(obj.total)
      ..writeByte(9)
      ..write(obj.oral);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CounselorMarkModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
