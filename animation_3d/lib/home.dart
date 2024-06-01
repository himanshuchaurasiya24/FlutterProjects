import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

double widthAndHeight = 100;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late AnimationController xController;
  late AnimationController yController;
  late AnimationController zController;
  late Tween<double> animation;
  @override
  void initState() {
    super.initState();
    xController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 20,
      ),
    );
    yController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 30,
      ),
    );
    zController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 40,
      ),
    );
    animation = Tween<double>(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    super.dispose();
    xController.dispose();
    yController.dispose();
    zController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    xController
      ..reset()
      ..repeat();
    yController
      ..reset()
      ..repeat();
    zController
      ..reset()
      ..repeat();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: widthAndHeight,
              width: double.infinity,
            ),
            AnimatedBuilder(
              animation: Listenable.merge(
                [
                  xController,
                  yController,
                  zController,
                ],
              ),
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateX(
                      animation.evaluate(xController),
                    )
                    ..rotateY(
                      animation.evaluate(yController),
                    )
                    ..rotateZ(
                      animation.evaluate(zController),
                    ),
                  child: Stack(
                    children: [
                      Transform(
                        transform: Matrix4.identity()
                          ..translate(
                            Vector3(0, 0, -widthAndHeight),
                          ),
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.purple,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(pi / 2),
                        child: Container(
                          color: Colors.red,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      Container(
                        color: Colors.green,
                        width: widthAndHeight,
                        height: widthAndHeight,
                      ),
                      Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(-pi / 2),
                        child: Container(
                          color: Colors.indigo,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.topCenter,
                        transform: Matrix4.identity()..rotateX(-pi / 2),
                        child: Container(
                          color: Colors.yellow,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                      Transform(
                        alignment: Alignment.bottomCenter,
                        transform: Matrix4.identity()..rotateX(pi / 2),
                        child: Container(
                          color: Colors.cyan,
                          width: widthAndHeight,
                          height: widthAndHeight,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
