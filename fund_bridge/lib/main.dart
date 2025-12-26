import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/fund_post_provider.dart';
import 'package:fund_bridge/providers/donationProvider.dart';
import 'package:fund_bridge/screens/login.dart';
import 'package:fund_bridge/screens/main_scaffold.dart';
import 'package:fund_bridge/screens/signup.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return DonationProvider();
          },
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        routes: {
          "/": (context) => MainScaffold(),
          "/login": (context) => Login(),
          "/signup": (context) => Signup(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
