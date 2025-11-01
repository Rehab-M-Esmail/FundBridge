import 'package:flutter/material.dart';
import 'common_appbar.dart';
class feedback extends StatelessWidget {
  const feedback({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'FundBridge'),
      body: Center(
        child: const Text('feedback Page'),
      ),
    );
  }
}
