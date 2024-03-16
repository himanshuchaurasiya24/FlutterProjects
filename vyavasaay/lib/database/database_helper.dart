import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:vyawasaay/models/diagnosis_info.dart';
import 'package:vyawasaay/models/doctor_model.dart';
import 'package:vyawasaay/models/incentive_gen_model.dart';

Database? _database;

class DatabaseHelper {
  final databaseName = 'diagnosis.db';
  String doctorTable = 'doctor';
  String diagnosisTable = 'diagnosis';
  String diagnosisQuery = '''
CREATE TABLE IF NOT EXISTS firstdia(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  patientName TEXT,
  patientAge TEXT,
  patientSex TEXT,
  date TEXT,
  dignosisType TEXT,
  diagnosisRemarks TEXT,
  totalAmount TEXT,
  paidAmount TEXT,
  incentiveAmount TEXT,
  incentivePercent TEXT,
  doctorId INTEGER,
  doctorName TEXT
)''';
  String doctorQuery = '''
CREATE TABLE IF NOT EXISTS firstdoc(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  doctorName TEXT,
  doctorAge TEXT,
  doctorSex TEXT,
  doctorPhoneNumber TEXT,
  address TEXT,
  incentivePercentage TEXT
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
        await db.execute(doctorQuery);
        await db.execute(diagnosisQuery);
      },
    );
    return _database!;
  }

  Future<void> deleteDoctorInfo({required id}) async {
    final db = await initDB();
    await db.delete('firstdoc', where: 'id = ?', whereArgs: [id]);
    await db.delete('firstdia', where: 'doctorId = ?', whereArgs: [id]);
  }

  Future<void> updateDoctorInfo({required DoctorModel model}) async {
    final db = await initDB();
    await db.update('firstdoc', model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }

  Future<void> deleteDiagnosisEntry({required int id}) async {
    final db = await initDB();
    await db.delete('firstdia', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DiagnosisInfo>> getDiagnosisHistory() async {
    final db = await initDB();
    final maps = await db.query('firstdia');
    return List.generate(
      maps.length,
      (index) => DiagnosisInfo(
          id: maps[index]['id'] as int,
          patientName: maps[index]['patientName'] as String,
          patientAge: maps[index]['patientAge'] as String,
          patientSex: maps[index]['patientSex'] as String,
          date: maps[index]['date'] as String,
          dignosisType: maps[index]['dignosisType'] as String,
          diagnosisRemarks: maps[index]['diagnosisRemarks'] as String,
          totalAmount: maps[index]['totalAmount'] as String,
          paidAmount: maps[index]['paidAmount'] as String,
          incentiveAmount: maps[index]['incentiveAmount'] as String,
          doctorId: maps[index]['doctorId'] as int,
          doctorName: maps[index]['doctorName'] as String,
          incentivePercent: maps[index]['incentivePercent'] as String),
    ).toList();
  }

  Future<List<DiagnosisInfo>> getDiagnosticHistoryByDoctorId(
      {required int id}) async {
    final db = await initDB();
    var res = await db
        .rawQuery("SELECT * FROM firstdia WHERE doctorId LIKE ?", ["%$id%"]);
    return res
        .map(
          (e) => DiagnosisInfo.fromMap(e),
        )
        .toList();
  }

  Future<List<DiagnosisInfo>> getDiagnosticHistoryByDoctorIdAndMonth(
      {required int id, required String date}) async {
    final db = await initDB();
    var res = await db.rawQuery(
        "SELECT * FROM firstdia WHERE doctorId LIKE ? AND date LIKE ?",
        ['$id%', '$date%']);
    return res
        .map(
          (e) => DiagnosisInfo.fromMap(e),
        )
        .toList();
  }

  Future<List<IncentiveGenModel>> getIncentiveGenModel(
      {required int id, required String date}) async {
    final db = await initDB();
    var res = await db.rawQuery(
      "SELECT * FROM firstdia WHERE doctorId LIKE ? AND date LIKE ?",
      ['$id%', '$date%'],
    );
    return res.map((e) => IncentiveGenModel.fromMap(e)).toList();
  }

  Future<List<DiagnosisInfo>> getDiagnosisHistorySearch(
      {required String date}) async {
    final db = await initDB();

    var result = await db
        .rawQuery("SELECT * FROM firstdia WHERE date LIKE ?", ["%$date%"]);
    return result
        .map(
          (e) => DiagnosisInfo.fromMap(e),
        )
        .toList();
  }

  Future<List<DoctorModel>> getDoctorsList() async {
    final db = await initDB();
    final maps = await db.query('firstdoc');
    return List.generate(
      maps.length,
      (index) => DoctorModel(
        id: maps[index]['id'] as int,
        doctorName: maps[index]['doctorName'] as String,
        doctorAge: maps[index]['doctorAge'] as String,
        doctorSex: maps[index]['doctorSex'] as String,
        doctorPhoneNumber: maps[index]['doctorPhoneNumber'] as String,
        address: maps[index]['address'] as String,
        incentivePercentage: maps[index]['incentivePercentage'] as String,
      ),
    ).toList();
  }

  Future<void> insertDiagnosisInfo(
      {required DiagnosisInfo diagnosisInfo}) async {
    final db = await initDB();
    await db.insert(
      'firstdia',
      diagnosisInfo.toMap(),
    );
  }

  Future<void> insertDoctor({required DoctorModel doctorModel}) async {
    final db = await initDB();
    await db.insert(
      'firstdoc',
      doctorModel.toMap(),
    );
  }

  Future<List<DiagnosisInfo>> searchDiagnosisInfo(
      {required String patientName}) async {
    final db = await initDB();
    final List<Map<String, Object?>> searchResult = await db.rawQuery(
        'select * from firstdia where patientName LIKE ?', ["%$patientName%"]);
    return searchResult.map((e) => DiagnosisInfo.fromMap(e)).toList();
  }

  Future<List<DoctorModel>> searchDoctor({required String doctorName}) async {
    final db = await initDB();
    final List<Map<String, Object?>> searchResult = await db.rawQuery(
        'select * from firstdoc where doctorName LIKE ?', ["%$doctorName%"]);
    return searchResult.map((e) => DoctorModel.fromMap(e)).toList();
  }
}
