// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achivement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AchivementAdapter extends TypeAdapter<Achivement> {
  @override
  final int typeId = 1;

  @override
  Achivement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Achivement(
      nameOfAchivement: fields[0] as String,
      id: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Achivement obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nameOfAchivement)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AchivementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
