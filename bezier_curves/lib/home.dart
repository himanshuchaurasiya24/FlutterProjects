import 'package:bezier_curves/clip_shadow_path.dart';
import 'package:bezier_curves/custom_clipers.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          ClipShadowPath(
            shadow: const BoxShadow(
              color: Colors.black,
              offset: Offset(4, 4),
              blurRadius: 4,
              spreadRadius: 20,
            ),
            clipper: BigClipper(),
            child: Container(
              color: Colors.orangeAccent,
            ),
          ),
          ClipShadowPath(
            shadow: const BoxShadow(
              color: Colors.black,
              offset: Offset(4, 4),
              blurRadius: 4,
              spreadRadius: 20,
            ),
            clipper: SmallClipper(),
            child: Container(
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
