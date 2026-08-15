// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'librarian_loans_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibrarianLoansModelAdapter extends TypeAdapter<LibrarianLoansModel> {
  @override
  final int typeId = 35;

  @override
  LibrarianLoansModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibrarianLoansModel(
      totalCount: fields[0] as int?,
      activeCount: fields[1] as int?,
      returnedCount: fields[2] as int?,
      loans: (fields[3] as List?)?.cast<LibrarianReservationModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, LibrarianLoansModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.totalCount)
      ..writeByte(1)
      ..write(obj.activeCount)
      ..writeByte(2)
      ..write(obj.returnedCount)
      ..writeByte(3)
      ..write(obj.loans);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibrarianLoansModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
