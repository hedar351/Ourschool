// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StudentFullProfileModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentFullProfileModelAdapter
    extends TypeAdapter<StudentFullProfileModel> {
  @override
  final int typeId = 25;

  @override
  StudentFullProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentFullProfileModel(
      message: fields[0] as String?,
      studentInfo: fields[1] as StudentInfoModel?,
      marksStatistics: fields[2] as MarksStatisticsModel?,
      semesterMarks1: (fields[3] as List?)?.cast<SemesterMarksModel>(),
      semesterMark2: (fields[4] as List?)?.cast<SemesterMarksModel>(),
      semester1Average: fields[5] as double?,
      semester2Average: fields[6] as double?,
      finalAverage: fields[7] as double?,
      attendance: (fields[8] as List?)?.cast<Attendancemodel>(),
      scheduleImage: fields[9] as String?,
      activities: (fields[10] as List?)?.cast<ActivitiesModel>(),
      warnings: (fields[11] as List?)?.cast<CounselorWarningModel>(),
      summons: (fields[12] as List?)?.cast<SummonsModel>(),
      loans: (fields[13] as List?)?.cast<LoanModel>(),
      statistics: fields[14] as StatisticsModel?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentFullProfileModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.studentInfo)
      ..writeByte(2)
      ..write(obj.marksStatistics)
      ..writeByte(3)
      ..write(obj.semesterMarks1)
      ..writeByte(4)
      ..write(obj.semesterMark2)
      ..writeByte(5)
      ..write(obj.semester1Average)
      ..writeByte(6)
      ..write(obj.semester2Average)
      ..writeByte(7)
      ..write(obj.finalAverage)
      ..writeByte(8)
      ..write(obj.attendance)
      ..writeByte(9)
      ..write(obj.scheduleImage)
      ..writeByte(10)
      ..write(obj.activities)
      ..writeByte(11)
      ..write(obj.warnings)
      ..writeByte(12)
      ..write(obj.summons)
      ..writeByte(13)
      ..write(obj.loans)
      ..writeByte(14)
      ..write(obj.statistics);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentFullProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
