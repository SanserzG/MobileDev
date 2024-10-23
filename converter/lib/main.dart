import 'package:flutter/material.dart';
import 'package:converter/pages/home.dart';
import 'package:converter/pages/weight.dart';
import 'package:converter/pages/temperature.dart';
import 'package:converter/pages/length.dart';
import 'package:converter/pages/money_exchange.dart';
import 'package:converter/pages/time.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      home: Home(),
      routes: {
        '/home': (context) => Home(),
        '/weight': (context) => Weight(),
        '/temperature': (context) => Temerature(),
        '/length': (context) => Length(),
        '/money': (context) => Money(),
        '/time': (context) => Time(),
      },
    );
  }
}


