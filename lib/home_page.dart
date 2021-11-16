import 'package:flutter/material.dart';

import 'components/refueling_form.dart';
import 'components/refueling_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
              Icons.directions_car_outlined,
            ),
            Text(
              "GásApp",
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            child: const Card(
              color: Colors.blue,
              child: Text("Gráfico"),
              elevation: 5,
            ),
          ),
          RefuelingList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
