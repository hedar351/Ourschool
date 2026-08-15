// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'librarian_reservation_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LibrarianReservationModelAdapter
    extends TypeAdapter<LibrarianReservationModel> {
  @override
  final int typeId = 34;

  @override
  LibrarianReservationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LibrarianReservationModel(
      id: fields[0] as int?,
      localBookNumber: fields[1] as int?,
      bookTitle: fields[2] as String?,
      bookAuthor: fields[3] as String?,
      localStudentNumber: fields[4] as int?,
      studentName: fields[5] as String?,
      sectionName: fields[6] as String?,
      localSectionNumber: fields[7] as int?,
      gradeName: fields[8] as String?,
      localGradeNumber: fields[9] as int?,
      date: fields[10] as String?,
      expiryDate: fields[11] as String?,
      isExpired: fields[12] as bool?,
      statusName: fields[13] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LibrarianReservationModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.localBookNumber)
      ..writeByte(2)
      ..write(obj.bookTitle)
      ..writeByte(3)
      ..write(obj.bookAuthor)
      ..writeByte(4)
      ..write(obj.localStudentNumber)
      ..writeByte(5)
      ..write(obj.studentName)
      ..writeByte(6)
      ..write(obj.sectionName)
      ..writeByte(7)
      ..write(obj.localSectionNumber)
      ..writeByte(8)
      ..write(obj.gradeName)
      ..writeByte(9)
      ..write(obj.localGradeNumber)
      ..writeByte(10)
      ..write(obj.date)
      ..writeByte(11)
      ..write(obj.expiryDate)
      ..writeByte(12)
      ..write(obj.isExpired)
      ..writeByte(13)
      ..write(obj.statusName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LibrarianReservationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
