import 'package:flutter/material.dart';
import 'login.dart';
import 'profile.dart';
import 'signup.dart';
import 'fundpost.dart';
import 'startfund.dart';
import 'donate.dart';
import 'report.dart';
import 'feedback.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FundBridge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => const MyHomePage(),
        '/Profile': (context) => const Profile(),
        '/login': (context) => const login(),
        '/signup': (context) => const signup(),
        '/fundpost': (context) => const fundpost(),
        '/startfund': (context) => const startfund(),
        '/donate': (context) => const donate(),
        '/report': (context) => const report(),
        '/feedback': (context) => const feedback(),
      },
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FundBridge Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: 'Go to Profile',
            onPressed: () {
              Navigator.pushNamed(context, '/Profile');
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text(
            'Navigation Test Page',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Navigation buttons
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            child: const Text('Go to Login Page'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/signup'),
            child: const Text('Go to Sign Up Page'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/fundpost'),
            child: const Text('Go to Fund Post Page'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/startfund'),
            child: const Text('Go to Start Fund Page'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/donate'),
            child: const Text('Go to Donate Page'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/report'),
            child: const Text('Go to Report Page'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/feedback'),
            child: const Text('Go to Feedback Page'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/Profile'),
            child: const Text('Go to Profile Page'),
          ),
        ],
      ),
    );
  }
}
