import 'dart:io';

import 'package:dummy/data_model.dart';
import 'package:dummy/diagnosisModel.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Database? _database;

class DatabaseHelper {
  final databaseName = 'abcdefgh.db';
  String query = '''
CREATE TABLE IF NOT EXISTS doctorrrr(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  address TEXT,
  phoneNumber TEXT,
  incentive INTEGER
)''';
  String diagnosisQuery = '''
CREATE TABLE IF NOT EXISTS diagnosiiiiiiisss(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  patientName TEXT,
  patientAge TEXT,
  patientSex TEXT,
  refBy TEXT,
  diagnosisRemark TEXT,
  totalAmount INTEGER,
  paid INTEGER,
  diagnosisType TEXT
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
        await db.execute(query);
        await db.execute(diagnosisQuery);
      },
    );
    return _database!;
  }

  Future<List<DiagnosisModel>> getDiagnosisModel() async {
    final db = await initDB();
    final maps = await db.query('diagnosiiiiiiisss');
    return List.generate(
      maps.length,
      (index) => DiagnosisModel(
        id: maps[index]['id'] as int,
        patientName: maps[index]['patientName'] as String,
        patientAge: maps[index]['patientAge'] as String,
        patientSex: maps[index]['patientSex'] as String,
        refBy: maps[index]['refBy'] as String,
        diagnosisRemark: maps[index]['diagnosisRemark'] as String,
        totalAmount: maps[index]['totalAmount'] as int,
        paid: maps[index]['paid'] as int,
        diagnosisType: maps[index]['diagnosisType'] as String,
      ),
    );
  }

  Future<List<DoctorModel>> getDoctorModel() async {
    final db = await initDB();
    final maps = await db.query('doctorrrr');
    return List.generate(
      maps.length,
      (index) => DoctorModel(
        id: maps[index]['id'] as int,
        name: maps[index]['name'] as String,
        address: maps[index]['address'] as String,
        phoneNumber: maps[index]['phoneNumber'] as String,
        incentive: maps[index]['incentive'] as int,
      ),
    ).toList();
  }

  Future<void> insertDiagnosisModel({required DiagnosisModel model}) async {
    final db = await initDB();
    await db.insert(
      'diagnosiiiiiiisss',
      model.toMap(),
    );
  }

  Future<void> insertDoctorModel({required DoctorModel model}) async {
    final db = await initDB();
    await db.insert(
      'doctorrrr',
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DiagnosisModel>> searchDiagnosisModel(
      {required String refBy}) async {
    final db = await initDB();
    final List<Map<String, Object?>> searchResult = await db.rawQuery(
        'select * from diagnosiiiiiiisss where refBy LIKE ?', ["%$refBy%"]);
    return searchResult.map((e) => DiagnosisModel.fromMap(e)).toList();
  }

  Future<List<DoctorModel>> searchDoctor({required String name}) async {
    final db = await initDB();
    final List<Map<String, Object?>> searchResult = await db
        .rawQuery('select * from doctorrrr where name LIKE ?', ["%$name%"]);
    return searchResult
        .map(
          (e) => DoctorModel.fromMap(e),
        )
        .toList();
  }
}
