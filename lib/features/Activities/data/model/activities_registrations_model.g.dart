// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activities_registrations_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActivitiesRegistrationsModelAdapter
    extends TypeAdapter<ActivitiesRegistrationsModel> {
  @override
  final int typeId = 42;

  @override
  ActivitiesRegistrationsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActivitiesRegistrationsModel(
      statistics: fields[0] as ActivitiesStatisticsModel?,
      registrations: (fields[1] as List?)?.cast<RegistrationsInfoModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ActivitiesRegistrationsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.statistics)
      ..writeByte(1)
      ..write(obj.registrations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivitiesRegistrationsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
