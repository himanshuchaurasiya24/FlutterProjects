import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:zaitoon_db_remember/provider/provider.dart';
import 'package:zaitoon_db_remember/views/auth.dart';
import 'package:zaitoon_db_remember/views/home.dart';

// video stopped at 13:19;
void main() {
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactoryOrNull = databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UiProvider()..initStorage(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            debugShowCheckedModeBanner: false,
            home: notifier.rememberMe
                ? const HomeScreen()
                : const Authentication(),
          );
        },
      ),
    );
  }
}
