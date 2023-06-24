import 'package:sale_stocks_pos/database/db.dart';

import '../models/stock.dart';

class AddStockItemController {
  // insert data
  Future<int> insertStockItem(StockItem stockItem) async {
    final db = await StockDB.db.database;
    final result = await db.insert('stock_item', stockItem.toMap());
    return result;
  }
}
