import 'package:sale_stocks_pos/database/db.dart';
import 'package:sqflite/sqflite.dart';

import '../models/stock.dart';

class StockItemListController {
  // retrieve data
  Future<List<StockItem>> retrieveStockItem() async {
    final Database db = await StockDB.db.database;
    final List<Map<String, Object?>> queryResult = await db.query('stock_item');
    return queryResult.map((e) => StockItem.fromMap(e)).toList();
  }

  // retrieve data by category
  Future<List<StockItem>> retrieveStockItemByCategory(String ctegory) async {
    final Database db = await StockDB.db.database;
    final List<Map<String, Object?>> queryResult = await db
        .query('stock_item', where: 'category = ? ', whereArgs: [ctegory]);
    return queryResult.map((e) => StockItem.fromMap(e)).toList();
  }

  // delete data
  Future<void> deleteStockItem(int id) async {
    final db = await StockDB.db.database;
    await db.delete(
      'stock_item',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
