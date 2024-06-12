import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineChart extends StatefulWidget {
  const LineChart({super.key});

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  List data = [
    [2005, 24, 55],
    [2006, 35, 48],
    [2007, 28, 60],
    [2008, 40, 52],
    [2009, 35, 75],
    [2010, 50, 67],
    [2011, 44, 81],
    [2012, 60, 88],
    [2013, 55, 77],
    [2014, 55, 77],
    [2015, 55, 77],
    [2016, 55, 77],
    [2017, 55, 77],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        legend: const Legend(
          isVisible: true,
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: 'Year'),
        ),
        primaryYAxis: const CategoryAxis(
          title: AxisTitle(text: 'Percentage%'),
        ),
        series: [
          SplineSeries(
            xValueMapper: (datum, index) => datum[0],
            yValueMapper: (datum, index) => datum[1],
            dataSource: data,
            color: Colors.redAccent,
            markerSettings:
                const MarkerSettings(isVisible: true, color: Colors.red),
            name: 'Import',
            // dashArray: const [
            //   40,
            // ],
          ),
          SplineSeries(
            xValueMapper: (datum, index) => datum[0],
            yValueMapper: (datum, index) => datum[2],
            dataSource: data,
            color: Colors.greenAccent,
            markerSettings:
                const MarkerSettings(isVisible: true, color: Colors.green),
            name: 'Export',
          )
        ],
      ),
    );
  }
}
