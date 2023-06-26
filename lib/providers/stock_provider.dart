import 'package:flutter/material.dart';
import 'package:sale_stocks_pos/controllers/stock_item_controller.dart';
import 'package:sale_stocks_pos/models/stock.dart';

class StockProvider extends ChangeNotifier {
  StockItemListController controller = StockItemListController();
  List<StockItem> stockItemList = [];
  int count = 0;

  Future<int> getStockItemCount() async {
    count = await controller.retrieveStockItemCount();
    notifyListeners();
    return count;
  }

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

  updateStockItem(StockItem stockItem) async {
    controller.updateStockItem(stockItem);
    stockItemList[stockItemList
        .indexWhere((element) => element.id == stockItem.id)] = stockItem;
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
    //controller.deleteStockItem(stockItem.id!);
    controller.updateStockItemStatus(stockItem.id!);
    stockItemList.remove(stockItem);
    notifyListeners();
  }

  void filterSearchResults(String name, String category) async {
    stockItemList = category == 'All'
        ? await getStockItem()
        : await getStockItemByCategory(category);
    stockItemList = stockItemList
        .where((item) => item.name!.toLowerCase().contains(name.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
