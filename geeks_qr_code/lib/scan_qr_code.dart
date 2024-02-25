import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  var data = '';
  Future<void> scanQr() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        data = qrCode.toString();
      });
    } on PlatformException {
      data = 'Failed to load QR Code';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 38,
              ),
              Text(
                data,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(
                height: 38,
              ),
              ElevatedButton(
                onPressed: () {
                  scanQr();
                },
                child: const Text('Scan Code'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
