import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../models/movie_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaeHelper;
  DatabaseHelper._instance() {
    _databaeHelper = this;
  }
  factory DatabaseHelper() => _databaeHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDb();
    }
    return _database;
  }

  static const String _tblWatchList = 'watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databsePath = '$path/ditonton.db';

    var db = await openDatabase(databsePath, version: 1, onCreate: _onCreate);

    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblWatchList (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblWatchList, movie.toJson());
  }

  Future<int> removeWatchlist(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblWatchList,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblWatchList,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblWatchList);

    return results;
  }
}
