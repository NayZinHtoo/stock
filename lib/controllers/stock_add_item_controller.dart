import 'package:sale_stocks_pos/database/db.dart';
import 'package:sqflite/sqflite.dart';

import '../models/stock.dart';

class AddStockItemController {
  late Database db;

  AddStockItemController() {
    _initDB();
  }
  Future _initDB() async {
    db = await StockDB.db.database;
  }

  // insert data
  Future<int> insertStockItem(StockItem stockItem) async {
    final result = await db.insert(
      'stock_item',
      stockItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return result;
  }
}
