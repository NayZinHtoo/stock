import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class StockDB with ChangeNotifier {
  static Database? _database;
  static final StockDB db = StockDB._();
  StockDB._();

  Future<Database> get database async {
    // If database exists, return database
    // If database don't exists, create one
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, 'pos.db');
    var db = await openDatabase(path,
        version: 1, onCreate: _createTable, onUpgrade: _updateTable);
    return db;
  }

  Future _updateTable(Database db, int oldVersion, int newVersion) async {
    /// alter table or field in update db version
  }

  Future _createTable(Database db, int version) async {
    await db.execute('CREATE TABLE IF NOT EXISTS stock_item('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'name TEXT NOT NULL,'
        'description TEXT NOT NULL,'
        'category TEXT NOT NULL,'
        'image TEXT NOT NULL'
        ')');
  }
}
