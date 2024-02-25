import 'package:flutter/material.dart';

class AlertDialogCustom extends StatefulWidget {
  const AlertDialogCustom({super.key});

  @override
  State<AlertDialogCustom> createState() => _AlertDialogCustomState();
}

class _AlertDialogCustomState extends State<AlertDialogCustom> {
  Future<void> showAlertDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Simple alert dialog',
          ),
          content: const SingleChildScrollView(
            child: ListBody(children: [
              Text(
                'Welcome to geeks for geeks',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ]),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Okay'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Alert Dialog'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  showAlertDialog();
                },
                child: const Text('Show native alert dialog'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      // return const CustomAlertDialog();
                      return const DisplayCustomAlertDialog();
                    },
                  );
                },
                child: const Text('Show custom Alert dialog'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: const Color(0xff3f8d46),
              child: Image.network(
                  'https://media.geeksforgeeks.org/wp-content/cdn-uploads/20190718110207/Screenshot-from-2019-07-18-11-01-14.png'),
            ),
          ),
          SizedBox(
            height: 177,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welocome to geeks for geeks!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Okay'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayCustomAlertDialog extends StatelessWidget {
  const DisplayCustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: const Color(0xff3f8d46),
              radius: 50,
              child: Image.network(
                "https://media.geeksforgeeks.org/wp-content/cdn-uploads/20190718110207/Screenshot-from-2019-07-18-11-01-14.png",
                height: 70,
                width: 70,
              ),
            ),
          ),
          SizedBox(
            height: 167,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                70,
                10,
                10,
              ),
              child: Column(
                children: [
                  const Text(
                    'Welcome to geeks for geeks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Okay'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
