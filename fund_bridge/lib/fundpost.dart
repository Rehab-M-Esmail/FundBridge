import 'package:flutter/material.dart';
import 'common_appbar.dart';
class fundpost extends StatelessWidget {
  const fundpost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'FundBridge'),
      body: Center(
        child: const Text('fundpost Page'),
      ),
    );
  }
}
