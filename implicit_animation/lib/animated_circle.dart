import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimatedCircle extends StatefulWidget {
  const AnimatedCircle({super.key});

  @override
  State<AnimatedCircle> createState() => _AnimatedCircleState();
}

class CircleClipper extends CustomClipper<Path> {
  const CircleClipper();
  @override
  Path getClip(Size size) {
    var path = Path();
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    );
    path.addOval(rect);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    throw UnimplementedError();
  }
}

Color getRandomColor() {
  return Color(
    0xFF000000 + math.Random().nextInt(0x00FFFFFF),
  );
}

class _AnimatedCircleState extends State<AnimatedCircle> {
  var color = getRandomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ClipPath(
          clipper: const CircleClipper(),
          child: TweenAnimationBuilder(
            tween: ColorTween(begin: getRandomColor(), end: color),
            duration: const Duration(milliseconds: 370),
            onEnd: () {
              setState(() {
                color = getRandomColor();
              });
            },
            curve: Curves.slowMiddle,
            child: Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            builder: (context, value, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  color,
                  BlendMode.srcATop,
                ),
                child: child!,
              );
            },
          ),
        ),
      ),
    );
  }
}
