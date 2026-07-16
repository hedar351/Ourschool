// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StudentsBySectionModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentsbysectionmodelAdapter
    extends TypeAdapter<Studentsbysectionmodel> {
  @override
  final int typeId = 5;

  @override
  Studentsbysectionmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Studentsbysectionmodel(
      success: fields[0] as bool?,
      message: fields[1] as String?,
      students: (fields[2] as List?)?.cast<Studentmodel>(),
    );
  }

  @override
  void write(BinaryWriter writer, Studentsbysectionmodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.success)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.students);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentsbysectionmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
