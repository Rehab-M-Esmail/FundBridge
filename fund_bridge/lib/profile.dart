import 'package:flutter/material.dart';
import 'common_appbar.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'FundBridge'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Page'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/fundpost');
              },
              child: const Text('Go to Fund Post'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/report');
              },
              child: const Text('Go to Report Page'),
            ),
          ],
        ),
      ),
    );
  }
}
