import 'package:flutter/material.dart';
import 'package:flutter3/Screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Flutter',
      home: HomeScreen(),
    );
  }
}