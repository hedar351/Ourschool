// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SemesterMarksModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SemesterMarksModelAdapter extends TypeAdapter<SemesterMarksModel> {
  @override
  final int typeId = 21;

  @override
  SemesterMarksModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SemesterMarksModel(
      localSubjectId: fields[0] as int?,
      subjectName: fields[1] as String?,
      oral: fields[2] as double?,
      maxOral: fields[3] as double?,
      quiz1: fields[4] as double?,
      maxQuiz1: fields[5] as double?,
      quiz2: fields[6] as double?,
      maxQuiz2: fields[7] as double?,
      homework: fields[8] as double?,
      maxHomework: fields[9] as double?,
      finalExam: fields[10] as double?,
      maxFinalExam: fields[11] as double?,
      total: fields[12] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, SemesterMarksModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.localSubjectId)
      ..writeByte(1)
      ..write(obj.subjectName)
      ..writeByte(2)
      ..write(obj.oral)
      ..writeByte(3)
      ..write(obj.maxOral)
      ..writeByte(4)
      ..write(obj.quiz1)
      ..writeByte(5)
      ..write(obj.maxQuiz1)
      ..writeByte(6)
      ..write(obj.quiz2)
      ..writeByte(7)
      ..write(obj.maxQuiz2)
      ..writeByte(8)
      ..write(obj.homework)
      ..writeByte(9)
      ..write(obj.maxHomework)
      ..writeByte(10)
      ..write(obj.finalExam)
      ..writeByte(11)
      ..write(obj.maxFinalExam)
      ..writeByte(12)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SemesterMarksModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
