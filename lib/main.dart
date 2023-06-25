import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sale_stocks_pos/providers/stock_add_provider.dart';
import 'package:sale_stocks_pos/providers/stock_provider.dart';
import 'package:sale_stocks_pos/utils/color_schemes.g.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: StockProvider()),
        ChangeNotifierProvider.value(value: StockAddProvider()),
      ],
      child: MaterialApp(
        title: 'Sale Stocks Pos',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: lightColorScheme,
            useMaterial3: true,
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 0, color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 0, color: Colors.white),
              ),
              filled: true,
              fillColor: lightColorScheme.surfaceVariant,
              border: InputBorder.none,
            )),
        darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
        home: const MyHomePage(title: 'Sale Stocks Pos'),
      ),
    );
  }
}
