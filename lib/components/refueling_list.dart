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
            return Center(
              heightFactor: 2,
              child: Column(
                children: [
                  Text(
                    "Hey, que tal abastecer?",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    constraints: const BoxConstraints.expand(
                      width: 250,
                      height: 250,
                    ),
                    child: Image.asset(
                      "assets/images/fuelempty.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (ctx, idx) {
                final refueling = box.getAt(idx) as Refueling;
                return Card(
                  margin: idx == box.length - 1
                      ? const EdgeInsets.only(
                          top: 4,
                          right: 4,
                          left: 4,
                          bottom: 80,
                        )
                      : const EdgeInsets.all(4),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
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
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primaryVariant,
                                  width: 2,
                                ),
                              ),
                              padding: const EdgeInsets.all(10),
                            ),
                            Positioned(
                              top: 15,
                              left: 135,
                              child: Text(
                                refueling.fuel.describe,
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
                              top: 5,
                              child: IconButton(
                                onPressed: () {
                                  box.deleteAt(idx);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).primaryColor,
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
