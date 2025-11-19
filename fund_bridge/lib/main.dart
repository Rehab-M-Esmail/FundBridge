import 'package:flutter/material.dart';
import 'package:fund_bridge/screens/fundpost.dart';
import 'package:fund_bridge/screens/fundpost2.dart';
import 'package:fund_bridge/donate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: donate());
  }
}
