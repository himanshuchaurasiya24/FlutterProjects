import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:vyavasaay_redesigned/screens/model/admin_model.dart';
import 'package:vyavasaay_redesigned/screens/model/user_model.dart';

Database? _database;

class DatabaseHelper {
  final databaseName = 'abcd.db';
  String adminTable = 'adminTable';
  String userTable = 'userTable';
  String userQuery = '''CREATE TABLE IF NOT EXISTS userTable(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,
    phoneNumber INT,
    password TEXT
  )''';
  String adminQuery = '''CREATE TABLE IF NOT EXISTS adminTable(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,
    phoneNumber INT,
    password TEXT
  )''';
  Future<Database> initDB() async {
    DatabaseFactory _databaseFactory;
    String path = '';
    if (!kIsWeb && Platform.isWindows) {
      sqfliteFfiInit();
      _databaseFactory = databaseFactoryFfi;
      final Directory _directory = await getApplicationSupportDirectory();
      await _databaseFactory.setDatabasesPath(_directory.path);
      path = join(
        await _databaseFactory.getDatabasesPath(),
        databaseName,
      );
    } else {
      _databaseFactory = databaseFactory;
      path = join(
        await _databaseFactory.getDatabasesPath(),
        databaseName,
      );
    }

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(adminQuery);
        await db.execute(userQuery);
      },
    );
    return _database!;
  }

  Future<String> createAdminAccount({required AdminModel model}) async {
    final db = await initDB();
    await db.insert(
      adminTable,
      model.toMap(),
    );
    return model.name;
  }

  Future<bool> authAdmin({
    required String name,
    required String password,
  }) async {
    final db = await initDB();
    var res = await db.query(adminTable,
        where: 'name = ? AND password = ?', whereArgs: [name, password]);
    if (res.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<AdminModel?> getAdmin({required String name}) async {
    final db = await initDB();
    var res = await db.query(adminTable, where: 'name = ?', whereArgs: [name]);
    return res.isNotEmpty ? AdminModel.fromMap(res.first) : null;
  }

  Future<UserModel?> getUser({required String name}) async {
    final db = await initDB();
    var res = await db.query(userTable, where: 'name = ?', whereArgs: [name]);
    return res.isNotEmpty ? UserModel.fromMap(res.first) : null;
  }

  Future<bool> authUser({
    required String name,
    required String password,
  }) async {
    final db = await initDB();
    var res = await db.query(userTable,
        where: 'name = ? AND password = ?', whereArgs: [name, password]);
    if (res.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createUserAccount({required UserModel model}) async {
    final db = await initDB();
    await db.insert(
      userTable,
      model.toMap(),
    );
  }

  Future<List<AdminModel>> getAllAdminAccount() async {
    final db = await initDB();
    final List<Map<String, Object?>> result =
        await db.rawQuery('SELECT * FROM $adminTable');
    return result.map((e) => AdminModel.fromMap(e)).toList();
  }

  Future<int> getAdminAccountLength() async {
    final db = await initDB();
    final List<Map<String, Object?>> result =
        await db.rawQuery('SELECT * FROM $adminTable');
    return result.length;
  }

  Future<List<UserModel>> getAllUserAccount() async {
    final db = await initDB();
    final List<Map<String, Object?>> result =
        await db.rawQuery('SELECT * FROM $userTable');
    return result.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<List<AdminModel>> getAdminInfo({required String name}) async {
    final db = await initDB();
    final List<Map<String, Object?>> searchResult = await db.rawQuery(
      'select * from adminTable where name LIKE ?',
      ["%$name%"],
    );
    return searchResult.map((e) => AdminModel.fromMap(e)).toList();
  }

  Future<List<UserModel>> getUserInfo({required String name}) async {
    final db = await initDB();
    final List<Map<String, Object?>> searchResult = await db.rawQuery(
      'select * from userTable where name LIKE ?',
      ["%$name%"],
    );
    return searchResult.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<void> deleteEverything() async {
    final db = await initDB();
    await db.rawDelete('DELETE FROM $adminTable');
    await db.rawDelete('DELETE FROM $userTable');
  }
}
