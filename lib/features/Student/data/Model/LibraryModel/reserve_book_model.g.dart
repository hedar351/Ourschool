// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReserveBookModelAdapter extends TypeAdapter<ReserveBookModel> {
  @override
  final int typeId = 28;

  @override
  ReserveBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReserveBookModel(
      id: fields[0] as int?,
      localBookNumber: fields[1] as int?,
      bookTitle: fields[2] as String?,
      date: fields[3] as String?,
      expiryDate: fields[4] as String?,
      status: fields[5] as String?,
      statusName: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ReserveBookModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.localBookNumber)
      ..writeByte(2)
      ..write(obj.bookTitle)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.expiryDate)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.statusName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReserveBookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
