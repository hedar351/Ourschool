// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SchoolInfoModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SchoolInfoModelAdapter extends TypeAdapter<SchoolInfoModel> {
  @override
  final int typeId = 17;

  @override
  SchoolInfoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SchoolInfoModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      typename: fields[2] as String?,
      address: fields[3] as String?,
      phone: fields[4] as String?,
      teacherInfo: (fields[5] as List?)?.cast<TeacherInfoModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SchoolInfoModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.typename)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.teacherInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SchoolInfoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
