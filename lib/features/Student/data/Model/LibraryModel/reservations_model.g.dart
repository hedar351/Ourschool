// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservations_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReservationsModelAdapter extends TypeAdapter<ReservationsModel> {
  @override
  final int typeId = 30;

  @override
  ReservationsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReservationsModel(
      message: fields[0] as String?,
      totalReservations: fields[1] as int?,
      pendingReservations: fields[2] as int?,
      approvedReservations: fields[3] as int?,
      reserveBookInfo: (fields[4] as List?)?.cast<ReserveBookModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReservationsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.totalReservations)
      ..writeByte(2)
      ..write(obj.pendingReservations)
      ..writeByte(3)
      ..write(obj.approvedReservations)
      ..writeByte(4)
      ..write(obj.reserveBookInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReservationsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
