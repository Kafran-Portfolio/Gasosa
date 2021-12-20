import 'package:flutter/material.dart';
import 'package:gasosa/components/chart_bar.dart';
import 'package:gasosa/main.dart';
import 'package:gasosa/model/refueling.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<Refueling>(GasosaApp.hiveBox).listenable(),
      builder: (ctx, Box<Refueling> box, _) {
        var monthlyRefueling = _monthlyRefueling(box);
        var totalMonthlyRefueling = _totalValue(monthlyRefueling);
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: monthlyRefueling.map((r) {
                return ChartBar(
                  label: r['month'] as String,
                  value: r['value'] as double,
                  percent: (totalMonthlyRefueling > 0) ? (r['value'] as double) / totalMonthlyRefueling : 0.0,
                  // percent: random.nextDouble(),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  List<Map<String, Object>> _monthlyRefueling(Box<Refueling> box) {
    return List.generate(6, (idx) {
      final now = DateTime.now();
      final pastMonth = DateTime(now.year, now.month - idx);

      final m = DateFormat.MMM().format(pastMonth);
      final total = box.values
          .where((it) => it.date.year == pastMonth.year && it.date.month == pastMonth.month)
          .map((r) => r.value)
          .fold<double>(0, (acc, value) => acc + value);

      return {
        'month': m,
        'value': total,
      };
    }).reversed.toList();
  }

  double _totalValue(List monthlyRefueling) {
    return monthlyRefueling.fold<double>(0.0, (sum, elem) {
      return sum + (elem['value'] as double);
    });
  }
}
