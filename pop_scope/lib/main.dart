import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/page1',
      routes: <String, WidgetBuilder>{
        '/page1': (BuildContext context) => const Page1(),
        '/page2': (BuildContext context) => const Page2(),
      },
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Page1',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/page2');
              },
              child: const Text(
                'Next Page',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  Future<bool?> _showDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are You Sure?'),
          content: const Text('Are you sure, You want to leave this page?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Page2',
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            PopScope(
              canPop: false,
              onPopInvoked: (didPop) async {
                if (didPop) {
                  return;
                }
                final bool shouldPop = await _showDialog() ?? false;
                if (shouldPop && context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: TextButton(
                  onPressed: () async {
                    final bool shouldPop = await _showDialog() ?? false;
                    if (shouldPop && context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Go Back',
                    style: TextStyle(
                      fontSize: 40,
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
