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
      category: fields[4] as String,
      inventorName: fields[5] as String,
      aiAnalysis: fields[6] as String,
      status: fields[7] as String,
      images: (fields[8] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Invention obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.inventorName)
      ..writeByte(6)
      ..write(obj.aiAnalysis)
      ..writeByte(7)
      ..write(obj.status)
      ..writeByte(8)
      ..write(obj.images);
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
