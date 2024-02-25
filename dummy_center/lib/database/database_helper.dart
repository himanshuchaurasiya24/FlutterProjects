import 'dart:io';

import 'package:dummy_center/models/doctor_model.dart';
import 'package:dummy_center/models/patient_model.dart';
import 'package:dummy_center/models/payment_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Database? _database;

class DatabaseHelper {
  final databaseName = 'cennntreee.db';

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
        await db.execute('''
CREATE TABLE IF NOT EXISTS patient(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  doctorId INTEGER,
  date TEXT,
  patientName TEXT,
  patientAge INTEGER,
  patientSex TEXT,
  diagnosisType TEXT,
  patientPhoneNumber TEXT,
  patientDiagnosisRemark TEXT
)
''');
        await db.execute('''
CREATE TABLE IF NOT EXISTS payment(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  doctorId INTEGER,
  patientId INTEGER,
  diagnosisType TEXT,
  totalAmount INTEGER,
  paidAmount INTEGER
)
''');
        await db.execute(
            '''CREATE TABLE IF NOT EXISTS doctor(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,address TEXT,phoneNumber TEXT
              )
''');
      },
    );
    return _database!;
  }

  Future<List<PatientModel>> getPatientModel() async {
    final db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('patient');
    return List.generate(
      maps.length,
      (index) => PatientModel(
        id: maps[index]['id'],
        doctorId: maps[index]['doctorId'],
        date: maps[index]['date'],
        patientName: maps[index]['patientName'],
        patientAge: maps[index]['patientAge'],
        patientSex: maps[index]['patientSex'],
        diagnosisType: maps[index]['diagnosisType'],
        patientPhoneNumber: maps[index]['patientPhoneNumber'],
        patientDiagnosisRemark: maps[index]['patientDiagnosisRemark'],
      ),
    );
  }

  Future<void> insertPatientModel({required PatientModel model}) async {
    final db = await initDB();
    await db.insert(
      'patient',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertDoctorModel({required DoctorModel model}) async {
    final Database db = await initDB();
    await db.insert(
      'doctor',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DoctorModel>> searchDoctorModel(
      {required String doctorName}) async {
    final Database db = await initDB();
    final List<Map<String, Object?>> searchResult = await db
        .rawQuery('select * from doctor where name LIKE ?', ["%$doctorName%"]);
    return searchResult.map((e) => DoctorModel.fromMap(e)).toList();
  }

  Future<List<DoctorModel>> getDoctorModel() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('doctor');
    return List.generate(
      maps.length,
      (index) => DoctorModel(
        id: maps[index]['id'] as int,
        name: maps[index]['name'] as String,
        address: maps[index]['address'] as String,
        phoneNumber: maps[index]['phoneNumber'] as String,
      ),
    );
  }

  Future<List<PaymentModel>> getPaymentModel() async {
    final Database db = await initDB();
    final List<Map<String, dynamic>> maps = await db.query('payment');
    return List.generate(
      maps.length,
      (index) => PaymentModel(
          id: maps[index]['id'] as int,
          doctorId: maps[index]['doctorId'] as int,
          patientId: maps[index]['patientId'] as int,
          diagnosisType: maps[index]['diagnosisType'] as String,
          totalAmount: maps[index]['totalAmount'] as int,
          paidAmount: maps[index]['paidAmount'] as int),
    );
  }

  Future<void> insertPaymentModel({required PaymentModel model}) async {
    final Database db = await initDB();
    await db.insert(
      'payment',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
