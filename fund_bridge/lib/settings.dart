import 'package:flutter/material.dart';
import 'common_appbar.dart';
class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'FundBridge'),
      body: Center(
        child: const Text('Settings Page'),
      ),
    );
  }
}
