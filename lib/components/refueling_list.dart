import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gasosa/components/gas_pump_animation.dart';
import 'package:gasosa/components/refueling_card.dart';
import 'package:gasosa/main.dart';
import 'package:gasosa/model/refueling.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class RefuelingList extends StatelessWidget {
  RefuelingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box<Refueling>(GasosaApp.hiveBox).listenable(),
        builder: (ctx, Box<Refueling> box, _) {
          if (box.values.isEmpty) {
            return GasPumpAnimation();
          }
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            primary: false,
            shrinkWrap: true,
            itemCount: box.length,
            itemBuilder: (ctx, idx) {
              final refueling = box.getAt(idx) as Refueling;
              return RefuelingCard(
                refueling: refueling,
                box: box,
                idx: idx,
              );
            },
          );
        });
  }
}
