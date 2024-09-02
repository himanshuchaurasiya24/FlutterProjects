import 'package:flutter/material.dart';
import 'package:plant_app_ui/colors.dart';
import 'package:plant_app_ui/universe_model.dart';

class PlanetDetailPage extends StatefulWidget {
  const PlanetDetailPage({super.key, required this.planetInfo});
  final PlanetInfo planetInfo;
  @override
  State<PlanetDetailPage> createState() => _PlanetDetailPageState();
}

class _PlanetDetailPageState extends State<PlanetDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: firstGradientColor,
      appBar: AppBar(
        backgroundColor: firstGradientColor,
        title: Text(
          widget.planetInfo.name,
          style: const TextStyle(
            fontSize: 45,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
                //
                ),
          )
        ],
      ),
    );
  }
}
