import 'package:currency_converter_app_sl/screens/home_with_cbBank.dart';
import 'package:currency_converter_app_sl/screens/riverpod_test_screen.dart';
import 'package:currency_converter_app_sl/screens/todo_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TodoHomeScreen(),
    );
  }
}
