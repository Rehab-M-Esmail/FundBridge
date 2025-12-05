import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/fund_post_provider.dart';
import 'homepage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FundPostProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FundBridge',
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
