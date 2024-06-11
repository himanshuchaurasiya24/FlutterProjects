import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartTutorial extends StatefulWidget {
  const ChartTutorial({super.key});

  @override
  State<ChartTutorial> createState() => _ChartTutorialState();
}

class _ChartTutorialState extends State<ChartTutorial> {
  List chartData = [
    [
      40,
      'Rent',
      Colors.lightBlue,
    ],
    [
      12,
      'Groceries',
      Colors.lightGreen,
    ],
    [
      20,
      'Utilities',
      Colors.limeAccent,
    ],
    [
      25,
      'Entertainment',
      Colors.pink,
    ],
    [
      15,
      'Transportation',
      Colors.purple,
    ],
    [
      10,
      'Others',
      Colors.teal,
    ],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: SfCircularChart(
          margin: const EdgeInsets.all(0),
          series: [
            PieSeries(
              // innerRadius: '80%',
              dataSource: chartData,
              yValueMapper: (datum, index) => datum[0],
              xValueMapper: (datum, index) => datum[1],
              // radius: '20%',
              // gap: '5',
              // maximumValue: 40,
              enableTooltip: true,
              explode: true,
              pointColorMapper: (datum, index) => datum[2],
              dataLabelMapper: (datum, index) =>
                  '${datum[0].toString()}% ${datum[1]}',
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                // alignment: ChartAlignment.center,
                // overflowMode: OverflowMode.shift,
                labelPosition: ChartDataLabelPosition.outside,
                borderWidth: 1,
                // borderRadius: 5,
                borderColor: Colors.black,
                connectorLineSettings: ConnectorLineSettings(
                  color: Colors.yellow,
                  width: 5,
                  length: '30',
                ),
                showZeroValue: true,
              ),
            )
          ],
          legend: const Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            orientation: LegendItemOrientation.auto,
            // backgroundColor: Colors.red,
            borderColor: Colors.red,
            borderWidth: 5,
            // isResponsive: true, --> ?
            // alignment: ChartAlignment.center,
          ),
        ),
      ),
    );
  }
}
