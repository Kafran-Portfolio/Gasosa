import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  // GoogleFonts.config.allowRuntimeFetching = false;
  runApp(GasosaApp());
}

class GasosaApp extends StatefulWidget {
  const GasosaApp({Key? key}) : super(key: key);

  static const hiveBox = 'refueling';

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
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: GoogleFonts.openSans(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              headline1: GoogleFonts.openSans(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              headline2: GoogleFonts.openSans(
                fontSize: 21.0,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
              headline3: GoogleFonts.openSans(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.pink,
              ),
              headline6: GoogleFonts.openSans(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
