// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_statistics_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivitiesStatisticsModelAdapter
    extends TypeAdapter<ActivitiesStatisticsModel> {
  @override
  final int typeId = 40;

  @override
  ActivitiesStatisticsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivitiesStatisticsModel(
      total: fields[0] as int?,
      pending: fields[1] as int?,
      approved: fields[2] as int?,
      rejected: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ActivitiesStatisticsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.total)
      ..writeByte(1)
      ..write(obj.pending)
      ..writeByte(2)
      ..write(obj.approved)
      ..writeByte(3)
      ..write(obj.rejected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivitiesStatisticsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
