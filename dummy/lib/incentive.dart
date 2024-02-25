import 'package:flutter/material.dart';

class IncentiveGenerator extends StatefulWidget {
  const IncentiveGenerator({super.key});

  @override
  State<IncentiveGenerator> createState() => _IncentiveGeneratorState();
}

class _IncentiveGeneratorState extends State<IncentiveGenerator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incentive Generator'),
        centerTitle: true,
      ),
      // body: ,
    );
  }
}
