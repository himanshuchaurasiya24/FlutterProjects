import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:path/path.dart';
import 'package:desktop_sqlite_app/json/account_json.dart';

Database? database;

class DatabaseHelper {
  final databaseName = 'zaitoontechnology.db';

  String accountTbl = '''
  CREATE TABLE IF NOT EXISTS accounts (
  accId INTEGER PRIMARY KEY AUTOINCREMENT,
  accHolder TEXT NOT NULL,
  accName TEXT NOT NULL,
  accStatus INTEGER,
  createdAt TEXT
  )''';
  Future<Database> init() async {
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
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(accountTbl);
      },
    );

    return database!;
    // final databasePath = await getApplicationDocumentsDirectory();
    // // final databasePath = await getApplicationSupportDirectory();
    // final path = '${databasePath.path}/$databaseName';
    // return openDatabase(
    //   path,
    //   version: 1,
    //   onCreate: (db, version) async {
    //     await db.execute(accountTbl);
    //   },
    // );
  }

  Future<List<AccountsJson>> getAccounts() async {
    final database = await init();
    List<Map<String, Object?>> result =
        await database.query('accounts', where: "accStatus=1");
    return result.map((e) => AccountsJson.fromMap(e)).toList();
  }

  Future<int> insertAccount(AccountsJson account) async {
    final database = await init();
    return database.insert(
      'accounts',
      account.toMap(),
    );
  }

  Future<int> updateAccount(String accHolder, String accName, int id) async {
    final database = await init();
    return database.rawUpdate(
        "update accounts set accHolder = ?, accName = ? where accId = ?",
        [accHolder, accName, id]);
  }

  Future<int> deleteAccount(int id) async {
    final database = await init();
    return database.delete('accounts', where: "accId = ?", whereArgs: [id]);
  }

  Future<List<AccountsJson>> filteredAccount(String keyword) async {
    final Database db = await init();
    List<Map<String, Object?>> result = await db.rawQuery(
        "SELECT * FROM accounts WHERE accHolder LIKE ? or accName LIKE ?",
        ["%$keyword%", "%$keyword%"]);
    return result
        .map(
          (e) => AccountsJson.fromMap(e),
        )
        .toList();
  }
}
