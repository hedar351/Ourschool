// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MarksStatisticsModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarksStatisticsModelAdapter extends TypeAdapter<MarksStatisticsModel> {
  @override
  final int typeId = 39;

  @override
  MarksStatisticsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MarksStatisticsModel(
      totalMarks: fields[0] as int?,
      passedSubjects: fields[1] as int?,
      failedSubjects: fields[2] as int?,
      successRate: fields[3] as int?,
      semester1Count: fields[4] as int?,
      semester2Count: fields[5] as int?,
      semester1Average: fields[6] as double?,
      semester2Average: fields[7] as double?,
      finalAverage: fields[8] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, MarksStatisticsModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.totalMarks)
      ..writeByte(1)
      ..write(obj.passedSubjects)
      ..writeByte(2)
      ..write(obj.failedSubjects)
      ..writeByte(3)
      ..write(obj.successRate)
      ..writeByte(4)
      ..write(obj.semester1Count)
      ..writeByte(5)
      ..write(obj.semester2Count)
      ..writeByte(6)
      ..write(obj.semester1Average)
      ..writeByte(7)
      ..write(obj.semester2Average)
      ..writeByte(8)
      ..write(obj.finalAverage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MarksStatisticsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
