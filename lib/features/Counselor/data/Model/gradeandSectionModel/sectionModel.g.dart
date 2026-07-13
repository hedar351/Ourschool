// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sectionModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SectionModelAdapter extends TypeAdapter<SectionModel> {
  @override
  final int typeId = 3;

  @override
  SectionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SectionModel(
      id: fields[0] as int?,
      nameSection: fields[1] as String?,
      localSectionNumber: fields[2] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SectionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nameSection)
      ..writeByte(2)
      ..write(obj.localSectionNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SectionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
