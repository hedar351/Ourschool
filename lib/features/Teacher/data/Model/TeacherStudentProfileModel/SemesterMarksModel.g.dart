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
      quiz1: fields[3] as double?,
      quiz2: fields[4] as double?,
      homework: fields[5] as double?,
      finalExam: fields[6] as double?,
      total: fields[2] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, SemesterMarksModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.localSubjectId)
      ..writeByte(1)
      ..write(obj.subjectName)
      ..writeByte(2)
      ..write(obj.total)
      ..writeByte(3)
      ..write(obj.quiz1)
      ..writeByte(4)
      ..write(obj.quiz2)
      ..writeByte(5)
      ..write(obj.homework)
      ..writeByte(6)
      ..write(obj.finalExam);
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
