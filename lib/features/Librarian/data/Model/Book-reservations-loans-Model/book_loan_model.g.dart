// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_loan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookLoanModelAdapter extends TypeAdapter<BookLoanModel> {
  @override
  final int typeId = 38;

  @override
  BookLoanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookLoanModel(
      id: fields[0] as int?,
      title: fields[1] as String?,
      localBookNumber: fields[2] as int?,
      author: fields[3] as String?,
      totalCopies: fields[4] as int?,
      availableCopies: fields[5] as int?,
      reservedCopies: fields[6] as int?,
      availableForLoan: fields[7] as int?,
      isAvailable: fields[8] as bool?,
      statisticsLoans: fields[9] as StatisticsLoansModel?,
      loans: (fields[10] as List?)?.cast<LibrarianReservationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, BookLoanModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.localBookNumber)
      ..writeByte(3)
      ..write(obj.author)
      ..writeByte(4)
      ..write(obj.totalCopies)
      ..writeByte(5)
      ..write(obj.availableCopies)
      ..writeByte(6)
      ..write(obj.reservedCopies)
      ..writeByte(7)
      ..write(obj.availableForLoan)
      ..writeByte(8)
      ..write(obj.isAvailable)
      ..writeByte(9)
      ..write(obj.statisticsLoans)
      ..writeByte(10)
      ..write(obj.loans);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookLoanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
