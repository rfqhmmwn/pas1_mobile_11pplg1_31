import 'dart:async';
import 'package:pas1_mobile_11pplg1_31/Menus/Sport/sportModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    _database = await _initDB('sports.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites (
        idTeam TEXT PRIMARY KEY,
        strTeam TEXT NOT NULL,
        strTeamBadge TEXT
      )
    ''');
  }

  Future<void> addFavorite(Welcome sport) async {
    final db = await instance.database;
    await db.insert(
      'favorites',
      {
        'idTeam': sport.idTeam,
        'strTeam': sport.strTeam,
        'strTeamBadge': sport.strTeamBadge
      },
    );
  }

  Future<bool> checkFavorite(String idTeam) async {
    final db = await instance.database;
    final result = await db.query(
      'favorites',
      where: 'idTeam = ?',
      whereArgs: [idTeam],
    );
    return result.isNotEmpty;
  }

  Future<List<Welcome>> getFavorites() async {
    final db = await instance.database;
    final result = await db.query('favorites');
    return result.map((map) => Welcome(
      idTeam: map['idTeam'] as String,
      strTeam: map['strTeam'] as String,
      strTeamBadge: map['strTeamBadge'] as String?,
    )).toList();
  }

  Future<void> removeFavorite(String idTeam) async {
    final db = await instance.database;
    await db.delete(
      'favorites',
      where: 'idTeam = ?',
      whereArgs: [idTeam],
    );
  }

  Future close() async {
    final db = await instance.database;
    await db.close();
    _database = null;
  }
}