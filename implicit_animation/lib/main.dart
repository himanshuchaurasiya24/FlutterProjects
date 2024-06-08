import 'package:flutter/material.dart';
import 'package:implicit_animation/animated_circle.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnimatedCircle(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var zoomedIn = true;
  var buttonTitle = 'Zoom In';
  double defaultWidth = 300;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 370),
              curve: zoomedIn ? Curves.easeOut : Curves.easeIn,
              height: zoomedIn ? MediaQuery.of(context).size.height / 2 : 200,
              width: defaultWidth,
              child: Image.asset('assets/images/wallpaper.jpg'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  zoomedIn = !zoomedIn;
                  buttonTitle = zoomedIn ? 'Zoom Out' : 'Zoom In';
                  defaultWidth = zoomedIn
                      ? MediaQuery.of(context).size.width.toDouble()
                      : 300.0;
                });
              },
              child: Text(buttonTitle),
            ),
          ],
        ),
      ),
    );
  }
}
