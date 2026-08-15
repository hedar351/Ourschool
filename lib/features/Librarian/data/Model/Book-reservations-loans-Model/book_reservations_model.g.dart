// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_reservations_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookReservationsModelAdapter extends TypeAdapter<BookReservationsModel> {
  @override
  final int typeId = 36;

  @override
  BookReservationsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookReservationsModel(
      id: fields[0] as int?,
      title: fields[1] as String?,
      localBookNumber: fields[2] as int?,
      author: fields[3] as String?,
      availableCopies: fields[4] as int?,
      reservedCopies: fields[5] as int?,
      availableForLoan: fields[6] as int?,
      librarianReservationsModel: fields[7] as LibrarianReservationsModel?,
    );
  }

  @override
  void write(BinaryWriter writer, BookReservationsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.localBookNumber)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.availableCopies)
      ..writeByte(5)
      ..write(obj.reservedCopies)
      ..writeByte(6)
      ..write(obj.availableForLoan)
      ..writeByte(7)
      ..write(obj.librarianReservationsModel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookReservationsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
