import 'package:flutter/material.dart';
import 'package:sale_stocks_pos/controllers/stock_add_item_controller.dart';
import 'package:sale_stocks_pos/models/stock.dart';

class StockAddProvider extends ChangeNotifier{

  AddStockItemController controller = AddStockItemController();

  addStockItem(StockItem stockItem) {
    controller.insertStockItem(stockItem);
    notifyListeners();
  }
}
