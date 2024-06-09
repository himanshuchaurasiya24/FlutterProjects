import 'package:flutter/material.dart';

class FlutterRangeSliderMy extends StatefulWidget {
  const FlutterRangeSliderMy({super.key});

  @override
  State<FlutterRangeSliderMy> createState() => _FlutterRangeSliderMyState();
}

class _FlutterRangeSliderMyState extends State<FlutterRangeSliderMy> {
  RangeValues values = const RangeValues(0, 100);
  @override
  Widget build(BuildContext context) {
    RangeLabels labels =
        RangeLabels(values.start.toString(), values.end.toString());
    return Scaffold(
      body: Center(
        child: RangeSlider(
          values: values,
          labels: labels,
          min: 0,
          max: 100,
          divisions: 20,
          activeColor: Colors.green[300],
          inactiveColor: Colors.red[400],
          overlayColor: WidgetStateColor.transparent,
          onChanged: (newValue) {
            setState(() {
              values = newValue;
            });
            debugPrint(newValue.start.toString() + newValue.end.toString());
          },
        ),
      ),
    );
  }
}
