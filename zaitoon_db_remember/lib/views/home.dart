import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zaitoon_db_remember/component/buttons.dart';
import 'package:zaitoon_db_remember/provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<UiProvider>(
              builder: (context, UiProvider notifier, child) {
                return Button(
                    buttonText: 'Sign Out',
                    press: () {
                      notifier.logout(context);
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
