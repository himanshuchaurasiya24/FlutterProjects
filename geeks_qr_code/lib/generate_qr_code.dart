import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class GenerateQRCode extends StatefulWidget {
  const GenerateQRCode({super.key});

  @override
  State<GenerateQRCode> createState() => _GenerateQRCodeState();
}

class _GenerateQRCodeState extends State<GenerateQRCode> {
  final controller = TextEditingController();
  bool isClicked = false;
  Widget createImage(String data) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: 200,
      errorStateBuilder: (context, error) {
        return Text(
          error.toString(),
          textAlign: TextAlign.center,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (controller.text.isNotEmpty) createImage(controller.text),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    setState(() {
                      createImage(value);
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Enter your data',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    createImage(controller.text);
                  });
                },
                child: const Text('Generate QR Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
