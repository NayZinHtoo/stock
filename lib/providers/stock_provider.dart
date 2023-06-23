import 'package:flutter/material.dart';
import 'package:sale_stocks_pos/database/db.dart';
import 'package:sale_stocks_pos/models/stock.dart';

class StockProvider extends ChangeNotifier {
  List<StockItem> stockItemList = [];

  getStockItem() async {
    stockItemList.clear();
    stockItemList.addAll(await StockDB.db.retrieveStockItem());
    notifyListeners();
    return stockItemList;
  }

  getStockItemByCategory(String category) async {
    stockItemList.clear();
    stockItemList
        .addAll(await StockDB.db.retrieveStockItemByCategory(category));
    notifyListeners();
    return stockItemList;
  }

  removeStockItemAll() {
    stockItemList = [];
    notifyListeners();
  }

  addStockItem(StockItem stockItem) {
    StockDB.db.insertStockItem(stockItem);
    stockItemList.add(stockItem);
    notifyListeners();
  }

  removeStockItem(StockItem stockItem) {
    StockDB.db.deleteStockItem(stockItem.id!);
    stockItemList.remove(stockItem);
    notifyListeners();
  }
}
