import 'package:flutter/material.dart';
import 'common_appbar.dart';
class donate extends StatelessWidget {
  const donate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const CommonAppBar(title: 'FundBridge'),
      body: Center(
        child: const Text('donate Page'),
      ),
    );
  }
}
