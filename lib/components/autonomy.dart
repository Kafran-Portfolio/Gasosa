import 'package:flutter/material.dart';
import 'package:gasosa/main.dart';
import 'package:gasosa/model/refueling.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Autonomy extends StatelessWidget {
  const Autonomy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Refueling>(GasosaApp.hiveBox).listenable(),
        builder: (ctx, Box<Refueling> box, _) {
          return Expanded(
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
                  child: Text(
                    "${_calcAutonomy(box).toStringAsFixed(2)} km/l",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
          );
        });
  }

  double _calcAutonomy(Box<Refueling> box) {
    if (box.isEmpty) {
      return 0.0;
    }
    var orderedBox = box.values.toList();
    orderedBox.sort((a, b) => a.date.compareTo(b.date));
    var firstKm = orderedBox.first.odometer;
    var lastKm = orderedBox.last.odometer;
    var totalKm = lastKm - firstKm;
    var totalLiters = orderedBox.map((r) => r.liters).fold<double>(0.0, (sum, elem) => sum + elem);
    return totalKm / totalLiters;
  }
}
