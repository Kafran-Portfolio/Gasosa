// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refueling.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RefuelingAdapter extends TypeAdapter<Refueling> {
  @override
  final int typeId = 0;

  @override
  Refueling read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Refueling(
      date: fields[0] as DateTime,
      fuel: fields[1] as Fuel,
      fuelPrice: fields[2] as double,
      liters: fields[3] as double,
      odometer: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Refueling obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.fuel)
      ..writeByte(2)
      ..write(obj.fuelPrice)
      ..writeByte(3)
      ..write(obj.liters)
      ..writeByte(4)
      ..write(obj.odometer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefuelingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FuelAdapter extends TypeAdapter<Fuel> {
  @override
  final int typeId = 1;

  @override
  Fuel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Fuel.gasoline;
      case 1:
        return Fuel.ethanol;
      case 2:
        return Fuel.diesel;
      default:
        return Fuel.gasoline;
    }
  }

  @override
  void write(BinaryWriter writer, Fuel obj) {
    switch (obj) {
      case Fuel.gasoline:
        writer.writeByte(0);
        break;
      case Fuel.ethanol:
        writer.writeByte(1);
        break;
      case Fuel.diesel:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FuelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
