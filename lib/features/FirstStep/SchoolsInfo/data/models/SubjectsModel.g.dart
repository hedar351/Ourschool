// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubjectsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubjectsModelAdapter extends TypeAdapter<SubjectsModel> {
  @override
  final int typeId = 14;

  @override
  SubjectsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubjectsModel(
      subjectId: fields[0] as int?,
      subjectName: fields[1] as String?,
      localSubjectId: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SubjectsModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.subjectId)
      ..writeByte(1)
      ..write(obj.subjectName)
      ..writeByte(2)
      ..write(obj.localSubjectId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubjectsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
