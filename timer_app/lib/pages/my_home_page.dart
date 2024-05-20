import 'dart:async';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Duration duration = const Duration();
  Timer? timer;
  bool isPaused = true;
  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused) {
        addTimer();
      }
    });
  }

  void addTimer() {
    duration = Duration(
      seconds: 1 + duration.inSeconds,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('rebuilt');
    return Scaffold(
      body: Center(
        child: buildTimerUi(),
      ),
    );
  }

  buildTimerUi() {
    String twoDigit(int value) => value.toString().padLeft(2, '0');
    String seconds = twoDigit(
      duration.inSeconds.remainder(60),
    );
    String minutes = twoDigit(
      duration.inMinutes.remainder(60),
    );
    String hours = twoDigit(
      duration.inHours.remainder(60),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildTimerContainer(
              'Hours',
              hours,
            ),
            const SizedBox(
              width: 20,
            ),
            buildTimerContainer(
              'Minutes',
              minutes,
            ),
            const SizedBox(
              width: 20,
            ),
            buildTimerContainer(
              'Second',
              seconds,
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            isPaused = true;
            timer = null;
            duration = Duration.zero;

            setState(() {});
          },
          child: Container(
            height: 60,
            width: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Stop',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            isPaused = !isPaused;
            setState(() {
              if (timer == null) {
                startTimer();
              }
            });
          },
          child: Container(
            height: 60,
            width: 120,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isPaused ? Colors.greenAccent : Colors.amberAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              isPaused ? 'Play' : 'Pause',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }

  buildTimerContainer(String s, String text) {
    return Column(
      children: [
        Container(
          height: 85,
          width: 85,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          s,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }
}
