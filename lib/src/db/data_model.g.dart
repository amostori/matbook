// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyDateAdapter extends TypeAdapter<MyDate> {
  @override
  final int typeId = 0;

  @override
  MyDate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyDate(
      id: fields[0] as String,
      days: fields[1] as int,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyDate obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.days)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyDateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
