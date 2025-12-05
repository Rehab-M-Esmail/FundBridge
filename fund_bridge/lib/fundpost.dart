import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/fund_post_provider.dart';
import 'models/fund_post.dart';

class FundPostPage extends StatefulWidget {
  const FundPostPage({Key? key}) : super(key: key);

  @override
  State<FundPostPage> createState() => _FundPostPageState();
}

class _FundPostPageState extends State<FundPostPage> {
  final TextEditingController _donationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FundPostProvider>(context);
    final post = provider.fundPost;

    final progress = (post.goalAmount > 0) ? (post.raisedAmount / post.goalAmount).clamp(0.0, 1.0) : 0.0;

    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              post.imagePath,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Text(post.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),

          
          Text('Collected: \$${post.raisedAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text('Goal: \$${post.goalAmount.toStringAsFixed(2)}'),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress, minHeight: 10),
          const SizedBox(height: 20),

         
          TextField(
            controller: _donationController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(labelText: 'Donation amount', border: OutlineInputBorder()),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _handleDonation(provider),
              child: const Text('Donate Now'),
            ),
          ),
          const SizedBox(height: 20),

        
          const Text('Top donors', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: post.topDonors.map((d) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      CircleAvatar(radius: 25, backgroundImage: AssetImage(d.avatarUrl)),
                      const SizedBox(height: 6),
                      Text('\$${d.amount.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(d.donorName),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 20),
          const Text('Comments', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Column(
            children: post.comments.map((c) {
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person)),
                title: Text(c.userName),
                subtitle: Text(c.comment),
                trailing: Text('\$${c.donatedAmount.toStringAsFixed(0)}'),
              );
            }).toList(),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => provider.toggleStarred(),
        child: Icon(provider.fundPost.isStarred ? Icons.star : Icons.star_border),
      ),
    );
  }

  void _handleDonation(FundPostProvider provider) {
    final text = _donationController.text.trim();
    final amount = double.tryParse(text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid amount')));
      return;
    }

    provider.updateDonations(amount);
    _donationController.clear();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Thank you for donating')));
  }
}
