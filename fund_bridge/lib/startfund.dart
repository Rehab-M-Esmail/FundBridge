import 'package:flutter/material.dart';
import 'common_appbar.dart';
class startfund extends StatelessWidget {
  const startfund({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'FundBridge'),
      body: Center(
        child: const Text('startfund Page'),
      ),
    );
  }
}
