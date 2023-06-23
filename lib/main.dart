import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_stocks_pos/providers/stock_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: StockProvider())],
      child: MaterialApp(
        title: 'Sale Stocks Pos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Sale Stocks Pos'),
      ),
    );
  }
}


