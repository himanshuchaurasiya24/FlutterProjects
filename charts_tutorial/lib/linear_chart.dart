import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LinearChart extends StatefulWidget {
  const LinearChart({super.key});

  @override
  State<LinearChart> createState() => _LinearChartState();
}

class _LinearChartState extends State<LinearChart> {
  List data = [
    ['Tea', 120, 80],
    ['Fish', 150, 100],
    ['Grains', 900, 120],
    ['Fuel', 80, 50],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        primaryXAxis:
            const CategoryAxis(title: AxisTitle(text: 'Commodities Exchange')),
        primaryYAxis: const CategoryAxis(
            title: AxisTitle(text: 'Import, Export in 2024')),
        series: [
          ColumnSeries(
            dataSource: data,
            xValueMapper: (datum, index) => datum[0],
            yValueMapper: (datum, index) => datum[1],
            color: Colors.red,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
            dataLabelMapper: (datum, index) => datum[0],
            name: 'Import',
          ),
          ColumnSeries(
            dataSource: data,
            xValueMapper: (datum, index) => datum[0],
            yValueMapper: (datum, index) => datum[2],
            color: Colors.green,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
            dataLabelMapper: (datum, index) => datum[0],
            name: 'Export',
          ),
        ],
        legend: const Legend(
          isVisible: true,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
        ),
      ),
    );
  }
}
