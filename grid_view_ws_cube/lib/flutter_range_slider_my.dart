import 'package:flutter/material.dart';

class FlutterRangeSliderMy extends StatefulWidget {
  const FlutterRangeSliderMy({super.key});

  @override
  State<FlutterRangeSliderMy> createState() => _FlutterRangeSliderMyState();
}

class _FlutterRangeSliderMyState extends State<FlutterRangeSliderMy> {
  RangeValues values = const RangeValues(100000000, 9999999999);
  @override
  Widget build(BuildContext context) {
    RangeLabels labels =
        RangeLabels(values.start.toString(), values.end.toString());
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text('Slide your phone number:'),
            RangeSlider(
              values: values,
              labels: labels,
              min: 100000000,
              max: 9999999999,
              divisions: 2,
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
          ],
        ),
      ),
    );
  }
}
