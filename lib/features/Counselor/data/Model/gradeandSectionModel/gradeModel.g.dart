// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gradeModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GradeModelAdapter extends TypeAdapter<GradeModel> {
  @override
  final int typeId = 2;

  @override
  GradeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GradeModel(
      gradeId: fields[0] as int?,
      gradeName: fields[1] as String?,
      localGradeNumber: fields[2] as int?,
      sections: (fields[3] as List?)?.cast<SectionModel>(),
      message: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GradeModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.gradeId)
      ..writeByte(1)
      ..write(obj.gradeName)
      ..writeByte(2)
      ..write(obj.localGradeNumber)
      ..writeByte(3)
      ..write(obj.sections)
      ..writeByte(4)
      ..write(obj.message);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
