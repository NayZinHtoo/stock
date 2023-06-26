import 'package:flutter/material.dart';
import 'package:sale_stocks_pos/controllers/stock_item_controller.dart';
import 'package:sale_stocks_pos/models/stock.dart';

class StockProvider extends ChangeNotifier {
  StockItemListController controller = StockItemListController();
  List<StockItem> stockItemList = [];

  getStockItem() async {
    stockItemList.clear();
    stockItemList.addAll(await controller.retrieveStockItem());
    notifyListeners();
    return stockItemList;
  }

  addStockItem(StockItem stockItem) async {
    stockItemList.add(stockItem);
    notifyListeners();
    return stockItemList;
  }

  getStockItemByCategory(String category) async {
    stockItemList.clear();
    stockItemList
        .addAll(await controller.retrieveStockItemByCategory(category));
    notifyListeners();
    return stockItemList;
  }

  removeStockItemAll() {
    stockItemList = [];
    notifyListeners();
  }

  removeStockItem(StockItem stockItem) {
    controller.deleteStockItem(stockItem.id!);
    stockItemList.remove(stockItem);
    notifyListeners();
  }

  void filterSearchResults(String query) async {
    stockItemList = await getStockItem();
    stockItemList = stockItemList
        .where((item) => item.name!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
