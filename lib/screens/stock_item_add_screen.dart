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
  final _stockNamecontroller = TextEditingController();
  final _stockDesccontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
      //print('Image File Path ########### ${imageTemp.toString()}');
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
    _stockNamecontroller.dispose();
    _stockDesccontroller.dispose();
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Stock name"),
                TextFormField(
                  controller: _stockNamecontroller,
                  decoration: const InputDecoration(
                    hintText: 'Enter stock name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Please enter stock name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),
                const Text("Stock description"),
                TextFormField(
                  controller: _stockDesccontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*Please enter stock description';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter stock description',
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 18),
                const Text("Category"),
                DropdownButtonFormField(
                  value: category,
                  decoration: const InputDecoration(),
                  icon: const Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 30,
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
                const SizedBox(height: 18),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        Text(
                          "image",
                          style: TextStyle(color: Colors.white),
                        ),
                      ]),
                  onPressed: () {
                    pickImage();
                  },
                ),
                const SizedBox(height: 18),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: image != null
                        ? Center(
                            child: Image.file(image!,
                                width: double.maxFinite,
                                height: 250,
                                fit: BoxFit.cover),
                          )
                        : const Text('*Please select an image'),
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
                    if (imageString == null || imageString == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Choose Image')),
                      );
                    }
                    if (_formKey.currentState!.validate()) {
                      var stockItem = StockItem(
                          id: stockProvider.stockItemList.length + 1,
                          name: _stockNamecontroller.text,
                          description: _stockDesccontroller.text,
                          category: category,
                          image: imageString);
                      stockAddProvider.addStockItem(stockItem);
                      stockProvider.addStockItem(stockItem);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
