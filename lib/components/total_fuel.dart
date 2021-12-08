import 'package:flutter/material.dart';
import 'package:gasosa/main.dart';
import 'package:gasosa/model/refueling.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TotalFuel extends StatelessWidget {
  const TotalFuel({Key? key}) : super(key: key);

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
                    "R\$ ${_totalValue(box).toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
          );
        });
  }

  double _totalValue(Box<Refueling> box) {
    return box.values.map((r) => r.value).fold<double>(0.0, (sum, elem) => sum + elem);
  }
}
