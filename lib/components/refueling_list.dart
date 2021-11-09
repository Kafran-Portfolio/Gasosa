import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gasosa/main.dart';
import 'package:gasosa/model/refueling.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class RefuelingList extends StatelessWidget {
  RefuelingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Refueling>(GasosaApp.hiveBox).listenable(),
        builder: (ctx, Box<Refueling> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text("No gasosa"));
          }
          return SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: box.length,
              itemBuilder: (ctx, idx) {
                final refueling = box.getAt(idx) as Refueling;
                final fuel = GasosaApp.fuels[refueling.fuel] ?? "NA";
                return Card(
                  elevation: 5,
                  child: Row(
                    children: [
                      Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "R\$ ${refueling.value.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.pink.shade700,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.pink.shade700,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(10),
                            ),
                            Positioned(
                              top: 15,
                              left: 135,
                              child: Text(
                                fuel,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 40,
                              left: 135,
                              child: Text(
                                "${refueling.odometer} KM",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              bottom: 5,
                              child: Text(
                                DateFormat('d MMM y').format(refueling.date),
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        });
  }
}
