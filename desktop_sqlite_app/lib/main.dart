import 'dart:io';

import 'package:desktop_sqlite_app/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

//44:09 zaitoontech
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    // Use the ffi on windows
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Ubuntu',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Menu(),
    );
  }
}
