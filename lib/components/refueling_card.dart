import 'package:flutter/material.dart';
import 'package:gasosa/model/refueling.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class RefuelingCard extends StatelessWidget {
  const RefuelingCard({
    Key? key,
    required this.refueling,
    required this.box,
    required this.idx,
  }) : super(key: key);

  final Refueling refueling;
  final int idx;
  final Box<Refueling> box;

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: idx == box.length - 1
      //     ? const EdgeInsets.only(
      //         top: 4,
      //         right: 4,
      //         left: 4,
      //         bottom: 80,
      //       )
      //     : const EdgeInsets.all(4),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
        side: BorderSide(
          color: Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Text(
          "R\$ ${refueling.value.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            box.deleteAt(idx);
          },
          icon: Icon(
            Icons.delete,
            color: Theme.of(context).primaryColor,
          ),
        ),
        title: Text(
          refueling.fuel.describe,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          "${refueling.odometer} KM\n${DateFormat('d MMM y').format(refueling.date)}",
          style: TextStyle(
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}
