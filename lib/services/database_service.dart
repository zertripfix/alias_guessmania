import 'dart:convert';

import 'package:alias/models/enums/dictionary.dart';
import 'package:alias/models/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/word.dart';

class DatabaseService {
  static Database? _database;
  static const int _batchSize = 10;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Для явной инициализации БД
  Future<void> init() async => _database = await _initDatabase();

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'alias.db');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDatabaseInitialized =
        prefs.getBool('isDatabaseInitialized') ?? false;

    final db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        for (var table in Dictionary.values) {
          await db.execute('''
            CREATE TABLE ${table.name} (
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              ru TEXT, 
              ua TEXT, 
              en TEXT, 
              sp TEXT, 
              isUsed INTEGER DEFAULT 0
            )
            ''');
        }

        await db.execute('''
          CREATE TABLE IF NOT EXISTS saves (
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            data STRING NOT NULL, 
            savedAt INTEGER NOT NULL
          )
          ''');
      },
    );

    if (!isDatabaseInitialized) {
      bool isImportSuccess = await _importDataFromCSV(db);
      if (isImportSuccess) {
        await prefs.setBool('isDatabaseInitialized', true);
      } else {
        throw Exception('Failed to import data from JSON files');
      }
    }

    return db;
  }

  Future<bool> _importDataFromCSV(Database db) async {
    try {
      bool isDataImported = false;
      for (var assetName in Dictionary.values) {
        String jsonString = await rootBundle.loadString(
          'assets/${assetName.name}.json',
        );
        final List<dynamic> jsonData = jsonDecode(jsonString);

        await db.transaction((txn) async {
          for (var row in jsonData) {
            await txn.insert(assetName.name, row);
          }
        });
        isDataImported = true;
      }
      return isDataImported;
    } catch (e) {
      if (kDebugMode) {
        print('Error importing CSV: $e');
      }
      return false;
    }
  }

  Future<List<Word>> getSomeUnusedWords(Dictionary dictionary) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      dictionary.name,
      where: 'isUsed = ?',
      whereArgs: [0],
      orderBy: 'RANDOM()',
      limit: _batchSize,
    );
    return List.generate(maps.length, (i) => Word.fromMap(maps[i]));
  }

  Future<List<String>> getWords(Dictionary dictionary) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(dictionary.name);
    return List.generate(maps.length, (i) => maps[i]['ru']);
  }

  //-------------- Save and load game state --------------

  Future<void> saveGame(Game game) async {
    final db = await database;

    return await db.transaction((txn) async {
      await txn.delete('saves');
      await txn.insert('saves', {
        'data': game.toJson(),
        'savedAt': DateTime.now().millisecondsSinceEpoch,
      });
    });
  }

  /// Throws exception if no save found
  Future<Game> loadSave() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'saves',
      orderBy: 'savedAt DESC',
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return Game.fromJson(maps.first['data']);
    }
    return throw Exception('No saved game found');
  }

  Future<bool> hasSave() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('saves', limit: 1);
    return maps.isNotEmpty;
  }

  Future<void> deleteSave() async {
    final db = await database;
    await db.delete('saves');
  }
}
