// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ActivitiesModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivitiesModelAdapter extends TypeAdapter<ActivitiesModel> {
  @override
  final int typeId = 23;

  @override
  ActivitiesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivitiesModel(
      activityName: fields[0] as String?,
      status: fields[1] as String?,
      date: fields[2] as String?,
      localActivityId: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ActivitiesModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.activityName)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.localActivityId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivitiesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
