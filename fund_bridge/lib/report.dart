import 'package:flutter/material.dart';
import 'common_appbar.dart';
class report extends StatelessWidget {
  const report({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'FundBridge'),
      body: Center(
        child: const Text('report Page'),
      ),
    );
  }
}
