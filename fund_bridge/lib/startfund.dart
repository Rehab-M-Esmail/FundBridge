import 'package:flutter/material.dart';

class startfund extends StatelessWidget {
  const startfund({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('startfund'),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: const Text('startfund Page'),
      ),
    );
  }
}
