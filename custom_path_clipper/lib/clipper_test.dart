import 'package:flutter/material.dart';

class ClipperTest extends StatelessWidget {
  const ClipperTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            ClipPath(
              clipper: ClipClipper(),
              child: Container(
                height: 300,
                width: 300,
                color: Colors.orange,
              ),
            ),
            // ClipPath(
            //   clipper: ClipClipper2(),
            //   child: Container(
            //     height: 300,
            //     width: 300,
            //     color: Colors.red,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class ClipClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    //
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width, 0, 0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class ClipClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(size.width, 0, 0, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
