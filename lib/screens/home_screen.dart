import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_stocks_pos/database/db.dart';
import 'package:sale_stocks_pos/models/stock.dart';
import 'package:sale_stocks_pos/providers/stock_provider.dart';
import 'package:sale_stocks_pos/screens/stock_item_add_screen.dart';
//import 'package:sale_stocks_pos/widgets/stock_list_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Column(
        children: [
          /*Container(
            decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller,
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) => (),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 0),
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
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              ElevatedButton(
                  onPressed: () {
                    stockProvider.getStockItem();
                  },
                  child: const Center(
                    child: Text('All'),
                  )),
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
          const Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              'Stoks Items',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ]),
          Consumer<StockProvider>(
            builder: (context, provider, _) {
              if (provider.stockItemList.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: provider.stockItemList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8.0),
                          title: Text(
                              provider.stockItemList[index].name.toString()),
                          subtitle: Text(provider
                              .stockItemList[index].image
                              .toString()),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddStockItemScreen()),
          );
          // int id = stockProvider.stockItemList.length;
          // StockItem s1 = StockItem(
          //     id: id,
          //     name: "All",
          //     description: "Alllllllllll",
          //     category: "All",
          //     image: "AlllImage1");
          // stockProvider.addStockItem(s1);
          // StockItem s2 = StockItem(
          //     id: id + 1,
          //     name: "Food",
          //     description: "Fooddddddddddddddd",
          //     category: "Food",
          //     image: "FoodImage1");
          // stockProvider.addStockItem(s2);
          // StockItem s3 = StockItem(
          //     id: id + 2,
          //     name: "Drink",
          //     description: "Drinkkkkkkkkk",
          //     category: "Drink",
          //     image: "Image1");
          // stockProvider.addStockItem(s3);
          // print(
          //     "ddddddddddddddddddddddddddddddddd ${stockProvider.stockItemList.length}");
        },
        tooltip: 'Add Stock',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
