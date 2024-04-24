import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:vyavasaay_redesigned/model/admin_model.dart';
import 'package:vyavasaay_redesigned/model/doctor_model.dart';
import 'package:vyavasaay_redesigned/model/patient_model.dart';
import 'package:vyavasaay_redesigned/model/user_model.dart';

Database? _database;

class DatabaseHelper {
  final databaseName = 'abcdefgh.db';
  String adminTable = 'adminTable';
  String userTable = 'userTable';
  String doctorTable = 'doctorTable';
  String patientTable = 'patientTable';
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
  String doctorQuery = '''
CREATE TABLE IF NOT EXISTS doctorTable(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  age INTEGER,
  sex TEXT,
  phone TEXT,
  address TEXT,
  ultrasound INTEGER,
  pathology INTEGER,
  ecg INTEGER,
  xray INTEGER
)''';
  String patientQuery = '''
CREATE TABLE IF NOT EXISTS patientTable(
  id TEXT,
  name TEXT,
  age INTEGER,
  sex TEXT,
  date TEXT,
  refBy TEXT,
  type TEXT,
  remark TEXT,
  technician TEXT,
  totalAmount INTEGER,
  paidAmount INTEGER,
  discDoc INTEGER,
  discCen INTEGER,
  incentive INTEGER,
  percent INTEGER
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
        await db.execute(doctorQuery);
        await db.execute(adminQuery);
        await db.execute(userQuery);
        await db.execute(patientQuery);
      },
    );
    return _database!;
  }

  //Patient
  Future<List<PatientModel>> getPatientList() async {
    final db = await initDB();
    final List<Map<String, Object?>> res = await db.query(patientTable);
    return res.map((e) {
      return PatientModel.fromMap(e);
    }).toList();
  }

  Future<int> addPatient({required PatientModel model}) async {
    final db = await initDB();
    final res = await db.insert(
      patientTable,
      model.toMap(),
    );
    return res;
  }

  Future<List<PatientModel>> searchPatient({required String name}) async {
    final db = await initDB();
    final List<Map<String, Object?>> result = await db
        .query(patientTable, where: 'name LIKE ?', whereArgs: ['%$name%']);
    return result.map((e) {
      return PatientModel.fromMap(e);
    }).toList();
  }

  Future<int> deletePatient({required int id}) async {
    final db = await initDB();
    final res = await db.delete(patientTable, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // doctor
  Future<List<DoctorModel>> getDoctorList() async {
    final db = await initDB();
    final List<Map<String, Object?>> res = await db.query(doctorTable);
    return res.map((e) => DoctorModel.fromMap(e)).toList();
  }

  Future<int> addDoctor({required DoctorModel model}) async {
    final db = await initDB();
    final res = await db.insert(doctorTable, model.toMap());
    return res;
  }

  Future<int> updateDoctor({required DoctorModel model}) async {
    final db = await initDB();
    return await db.update(
      doctorTable,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<int> deleteDoctor({required int id}) async {
    final db = await initDB();
    final res = await db.delete(doctorTable, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<List<DoctorModel>> searchDoctor({required String name}) async {
    final db = await initDB();
    final List<Map<String, Object?>> result = await db
        .query(doctorTable, where: 'name LIKE ?', whereArgs: ['%$name%']);
    return result.map((e) {
      return DoctorModel.fromMap(e);
    }).toList();
  }

  Future<DoctorModel> searchDoctorById({required int id}) async {
    final db = await initDB();
    final List<Map<String, Object?>> result =
        await db.query(doctorTable, where: 'id = ?', whereArgs: ['%$id%']);
    return result
        .map((e) {
          return DoctorModel.fromMap(e);
        })
        .toList()
        .first;
  }

// admin
  Future<int> createAdminAccount({required AdminModel model}) async {
    final db = await initDB();

    final value = await db.insert(
      adminTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return value;
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

// User
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

// Delete Everything
  Future<void> deleteEverything() async {
    final db = await initDB();
    await db.rawDelete('DELETE FROM $adminTable');
    await db.rawDelete('DELETE FROM $userTable');
    await db.rawDelete('DELETE FROM $doctorTable');
  }
}
