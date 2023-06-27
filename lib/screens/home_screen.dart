import 'dart:convert';

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sale_stocks_pos/providers/stock_provider.dart';
import 'package:sale_stocks_pos/screens/stock_item_add_screen.dart';
import 'package:sale_stocks_pos/screens/stock_item_detail_screen.dart';
import 'package:sale_stocks_pos/utils/constant.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late StockProvider stockProvider;
  final TextEditingController _controller = TextEditingController();

  String? selectedCategory;
  final List<String> categories = [
    'All',
    'Food',
    'Drink',
  ];

  _MyHomePageState() {
    selectedCategory = categories.first;
  }

  @override
  void initState() {
    stockProvider = Provider.of<StockProvider>(context, listen: false);
    stockProvider.getStockItem();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                    flex: 1,
                    child: TextFormField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.words,
                      onChanged: (value) {
                        stockProvider.filterSearchResults(
                            value, selectedCategory!);
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        hintText: 'Search',
                        prefixIcon: InkWell(
                            child: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 22,
                        )),
                      ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ChipsChoice<String>.single(
                  padding: const EdgeInsets.all(4),
                  value: selectedCategory,
                  onChanged: (value) {
                    if (value == "All") {
                      stockProvider.getStockItem();
                    } else {
                      stockProvider.getStockItemByCategory(value);
                    }
                    setState(() => selectedCategory = value);
                  },
                  choiceStyle: C2ChipStyle.outlined(
                    foregroundStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    backgroundColor: Colors.white,
                    elevation: 1.0,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                    selectedStyle: const C2ChipStyle(
                      foregroundStyle: TextStyle(color: Colors.white),
                      backgroundColor: AppColor.greenColor,
                      backgroundOpacity: 1.0,
                    ),
                  ),
                  choiceItems: C2Choice.listFrom<String, String>(
                    source: categories,
                    value: (i, v) => v,
                    label: (i, v) => v,
                  ),
                ),
              ],
            ),
          ),
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    stockProvider.getStockItem();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(color: Colors.white)),
                  child: const Center(
                    child: Text('All'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      stockProvider.getStockItemByCategory("Food");
                    },
                    child: const Center(
                      child: Text('Food'),
                    )),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () {
                      stockProvider.getStockItemByCategory("Drink");
                    },
                    child: const Center(
                      child: Text('Drink'),
                    )),
              ],
            ),
          ),*/
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                'Stocks Items',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ]),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xFFF2FDFF),
                  borderRadius: BorderRadius.circular(16)),
              height: double.maxFinite,
              width: double.maxFinite,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Swipe left to delete item',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey),
                  ),
                  Consumer<StockProvider>(
                    builder: (context, provider, _) {
                      if (provider.stockItemList.isNotEmpty) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              //physics: NeverScrollableScrollPhysics(),
                              itemCount: provider.stockItemList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            StockIemDetailScreen(
                                                stockItemId: provider
                                                    .stockItemList
                                                    .toList()[index]
                                                    .id),
                                      ),
                                    );
                                  },
                                  child: Dismissible(
                                    key: UniqueKey(),
                                    direction: DismissDirection.endToStart,
                                    onDismissed: (direction) {
                                      provider.removeStockItem(provider
                                          .stockItemList
                                          .toList()[index]);
                                    },
                                    background: Container(
                                      decoration: ShapeDecoration(
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                      alignment: Alignment.centerRight,
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.delete_sweep,
                                              color: Colors.white),
                                          Text(
                                            'Delete',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    child: Card(
                                      elevation: 8,
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 10,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(children: [
                                          Image.memory(
                                            Uint8List.fromList(base64.decode(
                                                '${provider.stockItemList[index].image}')),
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.fill,
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${provider.stockItemList[index].id}'),
                                                  Text(
                                                      '${provider.stockItemList[index].name}'),
                                                  Text(
                                                    '${provider.stockItemList[index].description}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 3,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ]),
                                      ),
                                      // child: ListTile(
                                      //   contentPadding: const EdgeInsets.all(8.0),
                                      //   leading: Image.memory(
                                      //     Uint8List.fromList(base64.decode(provider
                                      //         .stockItemList[index].image
                                      //         .toString())),
                                      //     height: 50,
                                      //     width: 50,
                                      //     fit: BoxFit.fill,
                                      //   ),
                                      //   title: Text(provider.stockItemList[index].name
                                      //       .toString()),
                                      //   subtitle: Text(provider
                                      //       .stockItemList[index].description
                                      //       .toString()),
                                      // ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        //return const Center(child: CircularProgressIndicator());
                        return const Expanded(
                            child: Center(
                                child: Text(
                          'No Data',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        )));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStockItemScreen()),
          );
        },
        backgroundColor: AppColor.greenColor,
        tooltip: 'Add Stock',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
