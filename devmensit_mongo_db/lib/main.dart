// import 'package:devmensit_mongo_db/dbHelper/display.dart';
// import 'package:devmensit_mongo_db/dbHelper/insert.dart';
import 'package:devmensit_mongo_db/dbHelper/mongodb.dart';
import 'package:devmensit_mongo_db/dbHelper/update.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UpdateMongoDb(),
    );
  }
}
