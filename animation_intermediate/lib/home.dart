import 'dart:math';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

enum CircleSide {
  left,
  right,
}

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();
    late Offset offset;
    late bool clockWise;
    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockWise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockWise = true;
        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(
        size.width / 2,
        size.height / 2,
      ),
      clockwise: clockWise,
    );
    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide circleSide;
  const HalfCircleClipper({required this.circleSide});
  @override
  Path getClip(Size size) {
    return circleSide.toPath(size);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController counterClockwiseController;
  late Animation<double> counterClockwiseAnimation;

  @override
  void initState() {
    super.initState();
    counterClockwiseController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
    counterClockwiseAnimation = Tween<double>(
      begin: 0,
      end: -pi / 2,
    ).animate(
      CurvedAnimation(
        parent: counterClockwiseController,
        curve: Curves.bounceOut,
      ),
    );
    // counterClockwiseController.forward();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(
        seconds: 1,
      ),
      () {
        counterClockwiseController
          ..reset()
          ..forward();
      },
    );
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: counterClockwiseController,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..rotateZ(counterClockwiseAnimation.value),
                  child: Row(
                    children: [
                      ClipPath(
                        clipper: const HalfCircleClipper(
                          circleSide: CircleSide.left,
                        ),
                        child: Container(
                          color: Colors.blue,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      ClipPath(
                        clipper: const HalfCircleClipper(
                          circleSide: CircleSide.right,
                        ),
                        child: Container(
                          color: Colors.yellow,
                          width: 200,
                          height: 200,
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
