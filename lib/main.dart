import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'home_page.dart';
import 'model/refueling.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await pathProvider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDir.path);
  Hive.registerAdapter(RefuelingAdapter());
  Hive.registerAdapter(FuelAdapter());
  runApp(GasosaApp());
}

class GasosaApp extends StatefulWidget {
  const GasosaApp({Key? key}) : super(key: key);

  static const hiveBox = 'refueling';
  static const fuels = <Fuel, String>{
    Fuel.gasoline: "Gasoline",
    Fuel.ethanol: "Ethanol",
    Fuel.diesel: "Diesel",
  };

  @override
  State<GasosaApp> createState() => _GasosaAppState();
}

class _GasosaAppState extends State<GasosaApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder(
          future: Hive.openBox<Refueling>(GasosaApp.hiveBox),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else if (snapshot.hasError) {
              return const Icon(Icons.error_outline);
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
