// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReserveModelAdapter extends TypeAdapter<ReserveModel> {
  @override
  final int typeId = 29;

  @override
  ReserveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReserveModel(
      message: fields[0] as String?,
      reserveBookInfo: fields[1] as ReserveBookModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ReserveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.reserveBookInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReserveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
