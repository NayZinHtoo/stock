import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sale_stocks_pos/models/stock.dart';
import 'package:sale_stocks_pos/providers/stock_provider.dart';

import '../providers/stock_add_provider.dart';

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
      print('Image File Path ########### ${imageTemp.toString()}');
      imagetoByteSting(imageTemp);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future imagetoByteSting(File imageFile) async {
    try {
      Uint8List imagebytes = await imageFile.readAsBytes(); //convert to bytes
      String base64string =
          base64.encode(imagebytes); //convert bytes to base64 string
      setState(() => imageString = base64string);
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
    final stockAddProvider =
        Provider.of<StockAddProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text('ADD ITEMS'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Stock name"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: stockNamecontroller,
                decoration: const InputDecoration(
                  hintText: 'Enter stock name',
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Stock description"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                controller: stockDesccontroller,
                decoration: const InputDecoration(
                  hintText: 'Enter stock description',
                ),
                maxLines: 5,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Category"),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: DropdownButtonFormField(
                value: category,
                decoration: const InputDecoration(),
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
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Row(
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
            const SizedBox(height: 18),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey.withAlpha(100),
                ),
                //padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                width: 250,
                height: 250,
                //color: Colors.grey[300],
                child: image != null
                    ? Center(
                        child: Image.file(image!,
                            width: 250, height: 250, fit: BoxFit.contain),
                      )
                    : const Text('Please select an image'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                onPressed: () {
                  var stockItem = StockItem(
                      id: stockProvider.stockItemList.length + 1,
                      name: stockNamecontroller.text,
                      description: stockDesccontroller.text,
                      category: category,
                      image: imageString);
                  stockAddProvider.addStockItem(stockItem);
                  stockProvider.addStockItem(stockItem);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
