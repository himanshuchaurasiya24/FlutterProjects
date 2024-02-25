import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqfl_windows/models/note.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Database? database;

class NotesRepository {
  // final _dbName = 'notesdb.db';
  final _tableName = 'notes';
  Future<Database> _database() async {
    DatabaseFactory _databaseFactory;
    String path = '';
    if (!kIsWeb && Platform.isWindows) {
      sqfliteFfiInit();
      _databaseFactory = databaseFactoryFfi;
      final Directory _directory = await getApplicationSupportDirectory();
      await _databaseFactory.setDatabasesPath(_directory.path);
      path = join(await _databaseFactory.getDatabasesPath(), "name.db");
    } else {
      _databaseFactory = databaseFactory;
      path = join(await _databaseFactory.getDatabasesPath(), "name.db");
    }
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            '''CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, createdAt TEXT)''');
      },
    );

    return database!;
  }

  Future<List<Note>> getNotes() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(
      maps.length,
      (index) {
        return Note(
          id: maps[index]['id'] as int,
          title: maps[index]['title'] as String,
          description: maps[index]['description'] as String,
          createdAt: DateTime.parse(maps[index]['createdAt']),
        );
      },
    );
  }

  Future<void> insert({required Note note}) async {
    final db = await _database();
    await db.insert(
      _tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateNotes({required Note note}) async {
    final db = await _database();
    await db.update(
      _tableName,
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    final db = await _database();
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
