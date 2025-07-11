import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartScreen extends StatelessWidget {
  const PieChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PieChart(
            dataMap: {
              "Key Plot": 41.7,
              "South": 25.0,
              "North": 16.7,
              "East": 16.7,
              'West': 20.0,
            },
            chartType: ChartType.ring, // Creates the donut shape
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              showChartValues: true,
              decimalPlaces: 1,
            ),
            legendOptions: const LegendOptions(
              showLegends: true,
              legendShape: BoxShape.rectangle,
              legendPosition: LegendPosition.right,
            ),
            colorList: [
              Colors.green,
              Colors.red,
              Colors.blue,
              Colors.orange,
              Colors.pink.shade400
            ],
            chartRadius: MediaQuery.of(context).size.width / 3.2,
          ),
        ],
      ),
    );
  }
}
