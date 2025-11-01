import 'package:flutter/material.dart';

class fundpost extends StatelessWidget {
  const fundpost({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('fundpost'),
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
        child: const Text('fundpost Page'),
      ),
    );
  }
}
