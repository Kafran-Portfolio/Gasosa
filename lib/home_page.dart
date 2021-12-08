import 'package:flutter/material.dart';
import 'package:gasosa/components/chart.dart';

import 'components/autonomy.dart';
import 'components/refueling_form.dart';
import 'components/refueling_list.dart';
import 'components/total_fuel.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Icons.directions_car_outlined,
            ),
            const SizedBox(width: 5),
            Text(
              "GasApp",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Chart(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                TotalFuel(),
                Autonomy(),
              ],
            ),
            RefuelingList(),
            const SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return const RefuelingForm();
            },
            isScrollControlled: true,
            constraints: const BoxConstraints(maxHeight: 550),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }
}
