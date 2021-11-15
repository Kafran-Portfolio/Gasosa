import 'package:hive/hive.dart';

part 'refueling.g.dart';

@HiveType(typeId: 0)
class Refueling {
  Refueling({
    required this.date,
    required this.fuel,
    required this.fuelPrice,
    required this.liters,
    required this.odometer,
  });

  @HiveField(0)
  final DateTime date;
  @HiveField(1)
  final Fuel fuel;
  @HiveField(2)
  final double fuelPrice;
  @HiveField(3)
  final double liters;
  @HiveField(4)
  final double odometer;

  double get value => fuelPrice * liters;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Refueling &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          fuel == other.fuel &&
          fuelPrice == other.fuelPrice &&
          liters == other.liters &&
          odometer == other.odometer;

  @override
  int get hashCode => date.hashCode ^ fuel.hashCode ^ fuelPrice.hashCode ^ liters.hashCode ^ odometer.hashCode;

  @override
  String toString() {
    return "Refuelling(date: $date, fuel: $fuel, odometer: $odometer, fuelPrice: $fuelPrice, liters: $liters)";
  }
}

@HiveType(typeId: 1)
enum Fuel {
  @HiveField(0)
  gasoline,
  @HiveField(1)
  ethanol,
  @HiveField(2)
  diesel
}

extension EnumDescribe on Fuel {
  String get describe {
    switch (this) {
      case Fuel.gasoline:
        return "Gasoline";
      case Fuel.ethanol:
        return "Ethanol";
      case Fuel.diesel:
        return "Diesel";
      default:
        throw Exception("Unknown Fuel $this");
    }
  }
}
