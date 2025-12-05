import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/fund_post_provider.dart';
import 'fundpost.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FundPostProvider>(context);
    final post = provider.fundPost;

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: SizedBox(width: 56, child: Image.asset(post.imagePath, fit: BoxFit.cover)),
            title: Text(post.title),
            subtitle: Text('Collected: \$${post.raisedAmount.toStringAsFixed(0)}'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FundPostPage()));
            },
          ),
        ],
      ),
    );
  }
}
