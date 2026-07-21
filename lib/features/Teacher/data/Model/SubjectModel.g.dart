// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectModelAdapter extends TypeAdapter<SubjectModel> {
  @override
  final int typeId = 13;

  @override
  SubjectModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectModel(
      subjectId: fields[0] as int?,
      localSubjectId: fields[1] as int?,
      subjectName: fields[2] as String?,
      grades: (fields[3] as List?)?.cast<GradeModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubjectModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.subjectId)
      ..writeByte(1)
      ..write(obj.localSubjectId)
      ..writeByte(2)
      ..write(obj.subjectName)
      ..writeByte(3)
      ..write(obj.grades);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
