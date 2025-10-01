import 'package:flutter/material.dart';
import 'package:flutter_shoppy_list/data/constants.dart';
import 'package:flutter_shoppy_list/widgets/grocery_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //* Set theeming

    return MaterialApp(
      title: 'Shoppy List',
      theme: MyAppTheme.lightTheme,
      darkTheme: MyAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: GroceryList(),
    );
  }
}
