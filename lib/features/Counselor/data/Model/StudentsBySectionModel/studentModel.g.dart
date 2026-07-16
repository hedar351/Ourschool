// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentmodelAdapter extends TypeAdapter<Studentmodel> {
  @override
  final int typeId = 4;

  @override
  Studentmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Studentmodel(
      id: fields[0] as int?,
      localStudentNumber: fields[1] as int?,
      name: fields[2] as String?,
      guardianName: fields[3] as String?,
      guardianPhone: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Studentmodel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.localStudentNumber)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.guardianName)
      ..writeByte(4)
      ..write(obj.guardianPhone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
