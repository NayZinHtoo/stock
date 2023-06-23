import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sale_stocks_pos/models/stock.dart';
import 'package:sale_stocks_pos/providers/stock_provider.dart';

class AddStockItemScreen extends StatefulWidget {
  const AddStockItemScreen({super.key});

  @override
  State<AddStockItemScreen> createState() => _AddStockItemScreenState();
}

class _AddStockItemScreenState extends State<AddStockItemScreen> {
  final stockNamecontroller = TextEditingController();
  final stockDesccontroller = TextEditingController();

  String category = 'All';
 

  var categories = [
    'All',
    'Food',
    'Drink',
  ];
  File? image;
  String? imageString;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
  Future imagetoByteSting() async {
    try {
      Uint8List imagebytes = await image!.readAsBytes(); //convert to bytes
      String base64string = base64.encode(imagebytes); //convert bytes to base64 string
      print(base64string);
       setState(() => this.imageString = base64string);
      //Uint8List decodedbytes = base64.decode(base64string);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void dispose() {
    stockNamecontroller.dispose();
    stockDesccontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = Provider.of<StockProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Center(child: Text('ADD ITEMS')),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Stock name"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: stockNamecontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter stock name',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Stock description"),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              controller: stockDesccontroller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter stock description',
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Category"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            width: 300.0,
            child: DropdownButton(
              value: category,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                textDirection: TextDirection.rtl,
              ),
              items: categories.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  category = newValue!;
                });
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.image),
                    Text("image"),
                  ]),
              onPressed: () {
                pickImage();
              },
            ),
          ),
          
          /*const SizedBox(height: 35),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 300,
            color: Colors.grey[300],
            child: image != null
                ? Image.file(image!, fit: BoxFit.cover)
                : const Text('Please select an image'),
          ),*/
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Save'),
                ],
              ),
              onPressed: () {
                var stockItem = StockItem(
                    id: stockProvider.stockItemList.length + 1,
                    name: stockNamecontroller.text,
                    description: stockDesccontroller.text,
                    category: category,
                    image: imageString);
                stockProvider.addStockItem(stockItem);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
