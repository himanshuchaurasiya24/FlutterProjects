import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment extends StatefulWidget {
  const RazorpayPayment({super.key});

  @override
  State<RazorpayPayment> createState() => _RazorpayPaymentState();
}

class _RazorpayPaymentState extends State<RazorpayPayment> {
  late Razorpay _razorpay;
  final _amountController = TextEditingController();
  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_1DP5mn0lF565ag',
      'amount': amount,
      'name': 'Geeks for Geeks',
      'prefill': {'contact': '1234567890', 'email': 'test@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: 'Payment successful ${response.paymentId}',
        toastLength: Toast.LENGTH_SHORT);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Payment failed ${response.message}',
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'External wallet ${response.walletName}',
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Razorpay Payment'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.network(
              'https://media.geeksforgeeks.org/wp-content/uploads/magnifyImage.png',
              height: 100,
              width: 300,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Wecome to razorpay payment gateway',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                autofocus: false,
                cursorColor: Colors.white,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: 'Enter the amount to be paid',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.purple),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple, width: 1.0),
                  ),
                  errorStyle: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),
                controller: _amountController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amout to be paid';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                if (_amountController.text.toString().isNotEmpty) {
                  setState(() {
                    int amount = int.parse(_amountController.text.toString());
                    openCheckout(amount);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
