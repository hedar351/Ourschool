// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics_loans_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatisticsLoansModelAdapter extends TypeAdapter<StatisticsLoansModel> {
  @override
  final int typeId = 37;

  @override
  StatisticsLoansModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatisticsLoansModel(
      totalLoans: fields[0] as int?,
      activeLoans: fields[1] as int?,
      returnedLoans: fields[2] as int?,
      overdueLoans: fields[3] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, StatisticsLoansModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.totalLoans)
      ..writeByte(1)
      ..write(obj.activeLoans)
      ..writeByte(2)
      ..write(obj.returnedLoans)
      ..writeByte(3)
      ..write(obj.overdueLoans);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatisticsLoansModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
