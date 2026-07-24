// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SectionsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionsModelAdapter extends TypeAdapter<SectionsModel> {
  @override
  final int typeId = 15;

  @override
  SectionsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SectionsModel(
      sectionId: fields[0] as int?,
      sectionName: fields[1] as String?,
      localSectionNumber: fields[2] as int?,
      gradeName: fields[3] as String?,
      localGradeNumber: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SectionsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sectionId)
      ..writeByte(1)
      ..write(obj.sectionName)
      ..writeByte(2)
      ..write(obj.localSectionNumber)
      ..writeByte(3)
      ..write(obj.gradeName)
      ..writeByte(4)
      ..write(obj.localGradeNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
