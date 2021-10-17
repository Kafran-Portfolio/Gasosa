import 'package:flutter/material.dart';

main() => runApp(GasosaApp());

class GasosaApp extends StatelessWidget {
  const GasosaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gasosa"),
      ),
      body: Center(
        child: Text("Versão Inicial"),
      ),
    );
  }
}
