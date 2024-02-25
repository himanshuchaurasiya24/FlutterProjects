import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:zaitoon_db_remember/json/user_model.dart';

Database? _database;

class DatabaseHelper {
  final databaseName = 'auth.db';
  String query = '''
CREATE TABLE IF NOT EXISTS users(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  fullName TEXT,
  email TEXT,
  userName TEXT,
  usrPassword TEXT
)
''';
  Future<Database> initDB() async {
    DatabaseFactory _databaseFactory;
    String path = '';
    if (!kIsWeb && Platform.isWindows) {
      sqfliteFfiInit();
      _databaseFactory = databaseFactoryFfi;
      final Directory _directory = await getApplicationSupportDirectory();
      await _databaseFactory.setDatabasesPath(_directory.path);
      path = join(await _databaseFactory.getDatabasesPath(), databaseName);
    } else {
      _databaseFactory = databaseFactory;
      path = join(await _databaseFactory.getDatabasesPath(), databaseName);
    }
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        db.execute(query);
      },
    );
    return _database!;
  }

  Future<bool> authenticate(UserModel model) async {
    final db = await initDB();
    var result = await db.rawQuery(
        "select * from users where userName = '${model.userName}' AND usrPassword = '${model.usrPassword}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<int> createUser(UserModel model) async {
    final db = await initDB();
    return await db.insert(
      'users',
      model.toMap(),
    );
  }

  Future<UserModel?> getUser(String userName) async {
    final db = await initDB();
    var res =
        await db.query('users', where: 'userName = ?', whereArgs: [userName]);
    return res.isNotEmpty ? UserModel.fromMap(res.first) : null;
  }
}
