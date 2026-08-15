// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'librarian_reservations_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibrarianReservationsModelAdapter
    extends TypeAdapter<LibrarianReservationsModel> {
  @override
  final int typeId = 33;

  @override
  LibrarianReservationsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibrarianReservationsModel(
      totalCount: fields[0] as int?,
      pendingCount: fields[1] as int?,
      approvedCount: fields[2] as int?,
      rejectedCount: fields[3] as int?,
      cancelledCount: fields[4] as int?,
      expiredCount: fields[5] as int?,
      reservations: (fields[6] as List?)?.cast<LibrarianReservationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, LibrarianReservationsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.totalCount)
      ..writeByte(1)
      ..write(obj.pendingCount)
      ..writeByte(2)
      ..write(obj.approvedCount)
      ..writeByte(3)
      ..write(obj.rejectedCount)
      ..writeByte(4)
      ..write(obj.cancelledCount)
      ..writeByte(5)
      ..write(obj.expiredCount)
      ..writeByte(6)
      ..write(obj.reservations);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibrarianReservationsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
