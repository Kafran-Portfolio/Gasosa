import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gasosa/main.dart';
import 'package:gasosa/model/refueling.dart';
import 'package:hive/hive.dart';

class RefuelingForm extends StatefulWidget {
  const RefuelingForm({Key? key}) : super(key: key);

  @override
  State<RefuelingForm> createState() => _RefuelingFormState();
}

class _RefuelingFormState extends State<RefuelingForm> {
  final _formKey = GlobalKey<FormState>();

  late Fuel _fuel;
  late String _fuelPrice;
  late String _liters;
  late String _odometer;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true), // Ensure decimal on iOS keyboard
                validator: _shouldNotBeEmpty,
                decoration: const InputDecoration(labelText: "Valor do combustível (R\$)"),
                onSaved: (value) => _fuelPrice = value!,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: _shouldNotBeEmpty,
                decoration: const InputDecoration(labelText: "Litros abastecidos"),
                onSaved: (value) => _liters = value!,
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: _shouldNotBeEmpty,
                decoration: const InputDecoration(labelText: "Quilometragem do veículo"),
                onSaved: (value) => _odometer = value!,
                textInputAction: TextInputAction.done,
              ),
              DropdownButtonFormField<Fuel>(
                onChanged: (value) {},
                validator: (value) => (value == null) ? "Campo obrigatório" : null,
                items: Fuel.values
                    .map((Fuel fuel) => DropdownMenuItem<Fuel>(
                          value: fuel,
                          child: Text(fuel.describe),
                        ))
                    .toList(),
                value: null,
                onSaved: (value) => _fuel = value!,
                hint: const Text("Combustível"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newRefueling = Refueling(
                      date: DateTime.now(),
                      fuel: _fuel,
                      fuelPrice: double.tryParse(_fuelPrice) ?? 0.0,
                      liters: double.tryParse(_liters) ?? 0.0,
                      odometer: double.tryParse(_odometer) ?? 0.0,
                    );
                    _saveRefueling(newRefueling);
                  }
                },
                icon: const Icon(Icons.local_gas_station),
                label: const Text("Abastecer"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink.shade700,
                  textStyle: TextStyle(
                    color: Colors.pink.shade700,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String? _shouldNotBeEmpty(value) {
    if (value == null || value.isEmpty) {
      return "Campo obrigatório!";
    }
    return null;
  }

  void _saveRefueling(Refueling refueling) {
    final refuelingBox = Hive.box<Refueling>(GasosaApp.hiveBox);
    refuelingBox.add(refueling);
    Navigator.of(context).pop();
  }
}
