import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sale_stocks_pos/models/stock.dart';
import 'package:sale_stocks_pos/providers/stock_provider.dart';
import 'package:sale_stocks_pos/screens/stock_item_add_screen.dart';

class StockIemDetailScreen extends StatefulWidget {
  final int? stockItemId;
  const StockIemDetailScreen({super.key, required this.stockItemId});

  @override
  State<StockIemDetailScreen> createState() => _StockIemDetailScreenState();
}

class _StockIemDetailScreenState extends State<StockIemDetailScreen> {
  StockItem? stockItem;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddStockItemScreen(
                          stockItem: stockItem,
                        )),
              );
            },
            icon: const Icon(Icons.mode_edit_outlined),
          ),
        ],
        title: const Text('Sale Stocks Pos'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Consumer<StockProvider>(builder: (context, provider, _) {
              final tempStockItem = provider.stockItemList
                  .where((item) => item.id == widget.stockItemId)
                  .toList()[0];
              stockItem = tempStockItem;
              return Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
                color: Colors.grey.withOpacity(0.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.memory(
                        Uint8List.fromList(
                            base64.decode(stockItem!.image.toString())),
                        height: 250,
                        width: double.maxFinite,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      decoration: BoxDecoration(
                          color: const Color(0xFFF2FDFF),
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stockItem!.name.toString(),
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            stockItem!.description.toString(),
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
