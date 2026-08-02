// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invention.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InventionAdapter extends TypeAdapter<Invention> {
  @override
  final int typeId = 0;

  @override
  Invention read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invention(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      createdAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Invention obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InventionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
