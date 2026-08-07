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
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentFullProfileModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;

  @override
  StudentFullProfileModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentFullProfileModel(
      message: fields[0] as String?,
      studentInfo: fields[1] as StudentInfoModel?,
      statistics: fields[2] as StatisticsModel?,
      semesterMarks1: (fields[3] as List?)?.cast<SemesterMarksModel>(),
      semesterMark2: (fields[4] as List?)?.cast<SemesterMarksModel>(),
      attendance: (fields[5] as List?)?.cast<Attendancemodel>(),
      scheduleImage: fields[6] as String?,
      activities: (fields[7] as List?)?.cast<ActivitiesModel>(),
      warnings: (fields[8] as List?)?.cast<CounselorWarningModel>(),
      summons: (fields[9] as List?)?.cast<SummonsModel>(),
      loans: (fields[10] as List?)?.cast<LoanModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, StudentFullProfileModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(1)
      ..write(obj.studentInfo)
      ..writeByte(2)
      ..write(obj.statistics)
      ..writeByte(3)
      ..write(obj.semesterMarks1)
      ..writeByte(4)
      ..write(obj.semesterMark2)
      ..writeByte(5)
      ..write(obj.attendance)
      ..writeByte(6)
      ..write(obj.scheduleImage)
      ..writeByte(7)
      ..write(obj.activities)
      ..writeByte(8)
      ..write(obj.warnings)
      ..writeByte(9)
      ..write(obj.summons)
      ..writeByte(10)
      ..write(obj.loans);
  }
}
