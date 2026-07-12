// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnnouncementActivityModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnnouncementActivityModelAdapter
    extends TypeAdapter<AnnouncementActivityModel> {
  @override
  final int typeId = 0;

  @override
  AnnouncementActivityModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnnouncementActivityModel(
      id: fields[0] as int,
      title: fields[1] as String,
      description: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, AnnouncementActivityModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnouncementActivityModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
