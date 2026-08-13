// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BulletinModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BulletinmodelAdapter extends TypeAdapter<Bulletinmodel> {
  @override
  final int typeId = 1;

  @override
  Bulletinmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bulletinmodel(
      message: fields[0] as String,
      announcements: (fields[1] as List?)?.cast<AnnouncementActivityModel>(),
      activities: (fields[2] as List?)?.cast<AnnouncementActivityModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, Bulletinmodel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.announcements)
      ..writeByte(2)
      ..write(obj.activities);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BulletinmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
