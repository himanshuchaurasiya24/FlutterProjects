import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:vyavasaay_redesigned/model/admin_model.dart';
import 'package:vyavasaay_redesigned/model/doctor_model.dart';
import 'package:vyavasaay_redesigned/model/user_model.dart';

Database? _database;

class DatabaseHelper {
  final databaseName = 'abcde.db';
  String adminTable = 'adminTable';
  String userTable = 'userTable';
  String doctorTable = 'doctorTable';
  String userQuery = '''CREATE TABLE IF NOT EXISTS userTable(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,
    phoneNumber TEXT,
    password TEXT
  )''';
  String adminQuery = '''CREATE TABLE IF NOT EXISTS adminTable(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT UNIQUE,
    phoneNumber TEXT,
    password TEXT
  )''';
  String doctorQuery = '''CREATE TABLE IF NOT EXISTS doctorTable(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INT,
    sex TEXT,
    phone TEXT,
    address TEXT,
    ultrasound INT,
    pathology INT,
    ecg INT,
    xray INT
  )
''';
  String patientQuery = '''CREATE TABLE IF NOT EXISTS patientTable(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    age INT,
    sex TEXT,
    date TEXT,
    doctor INT,
    type TEXT,
    remark TEXT,
    technician TEXT,
    totalAmount INT,
    paidAmount INT,
    incentive INT,
    percent INT
  )
''';
  String loginHistory = '''CREATE TABLE IF NOT EXISTS loginHistory(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    personId INT,
    name TEXT,
    time TEXT,
    type TEXT
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
        await db.execute(patientQuery);
        await db.execute(doctorQuery);
      },
    );
    return _database!;
  }

  // doctor
  Future<int> addDoctor({required DoctorModel model}) async {
    final db = await initDB();
    var intV = 00;
    await db
        .insert(
      doctorTable,
      model.toMap(),
    )
        .then((value) {
      intV = value;
    });
    return intV;
  }

  Future<List<DoctorModel>> getAllDoctorList() async {
    final db = await initDB();
    final List<Map<String, Object?>> result =
        await db.rawQuery('select * from $doctorTable');
    return result.map((e) {
      return DoctorModel.fromMap(e);
    }).toList();
  }

  Future<List<DoctorModel>> searchDoctor({required String name}) async {
    final db = await initDB();
    final List<Map<String, Object?>> result = await db
        .query(doctorTable, where: 'name LIKE ?', whereArgs: ['%$name%']);
    return result.map((e) {
      return DoctorModel.fromMap(e);
    }).toList();
  }

// admin
  Future<String> createAdminAccount({required AdminModel model}) async {
    final db = await initDB();

    await db.insert(
      adminTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
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

  Future<void> createUserAccount({required UserModel model}) async {
    final db = await initDB();
    await db.insert(
      userTable,
      model.toMap(),
    );
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

  Future<UserModel?> getUser({required String name}) async {
    final db = await initDB();
    var res = await db.query(userTable, where: 'name = ?', whereArgs: [name]);
    return res.isNotEmpty ? UserModel.fromMap(res.first) : null;
  }

  Future<List<UserModel>> getAllUserAccount() async {
    final db = await initDB();
    final List<Map<String, Object?>> result =
        await db.rawQuery('SELECT * FROM $userTable');
    return result.map((e) => UserModel.fromMap(e)).toList();
  }

  Future<int> getUserAccountLength() async {
    final db = await initDB();
    final List<Map<String, Object?>> result =
        await db.rawQuery('SELECT * FROM $userTable');
    return result.length;
  }

  Future<void> deleteEverything() async {
    final db = await initDB();
    await db.rawDelete('DELETE FROM $adminTable');
    await db.rawDelete('DELETE FROM $userTable');
    await db.rawDelete('DELETE FROM $doctorTable');
  }
}
