import 'package:flutter/material.dart';
import 'common_appbar.dart';
class signup extends StatelessWidget {
  const signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const CommonAppBar(title: 'FundBridge'),
      body: Center(
        child: const Text('Sign Up Page'),
      ),
    );
  }
}
