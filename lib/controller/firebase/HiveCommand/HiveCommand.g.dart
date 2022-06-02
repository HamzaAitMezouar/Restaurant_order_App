// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HiveCommand.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommandHiveAdapter extends TypeAdapter<CommandHive> {
  @override
  final int typeId = 0;

  @override
  CommandHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CommandHive()
      ..name = fields[0] as String
      ..image = fields[1] as String
      ..itemPrice = fields[2] as double
      ..total = fields[3] as double
      ..friesPrice = fields[4] as double
      ..fries = fields[5] as String
      ..isReady = fields[6] as bool;
  }

  @override
  void write(BinaryWriter writer, CommandHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.itemPrice)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.friesPrice)
      ..writeByte(5)
      ..write(obj.fries)
      ..writeByte(6)
      ..write(obj.isReady);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommandHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
