import 'package:flutter/material.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';
import 'package:provider/provider.dart';
import '../providers/fund_post_provider.dart';
import '../models/fund_post.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  State<DonatePage> createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  final TextEditingController _donationController = TextEditingController();

  @override
  void dispose() {
    _donationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FundPostProvider>(context);
    final post = provider.fundPost;

    final progress = (post.goalAmount > 0)
        ? (post.raisedAmount / post.goalAmount).clamp(0.0, 1.0)
        : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          post.title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Poppins",
            fontWeight: FontWeight.bold,
            color: Color(0xff333333),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Text(
              post.description,
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            const SizedBox(height: 12),

            Text(
              'Collected: \$${post.raisedAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            Text(
              'Goal: \$${post.goalAmount.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 17,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Color(0xff333333),
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              color: Color(0xff008748),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _donationController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Color(0xff02A95C), width: 3),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: LongButton(
                text: 'Donate Now',
                action: () => _handleDonation(provider),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Top donors',
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                color: Color(0xff333333),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: post.topDonors.map((d) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(d.avatarUrl),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '\$${d.amount.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: Color(0xff333333),
                          ),
                        ),
                        Text(
                          d.donorName,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            color: Color(0xff333333),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Comments',
              style: TextStyle(
                fontSize: 17,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            const SizedBox(height: 8),
            Column(
              children: post.comments.map((c) {
                return ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(
                    c.userName,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333),
                    ),
                  ),
                  subtitle: Text(
                    c.comment,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      color: Color(0xff333333),
                    ),
                  ),
                  trailing: Text(
                    '\$${c.donatedAmount.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      color: Color(0xff333333),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => provider.toggleStarred(),
        child: Icon(
          provider.fundPost.isStarred ? Icons.star : Icons.star_border,
          color: Color(0xff008748),
        ),
      ),
    );
  }

  void _handleDonation(FundPostProvider provider) {
    final text = _donationController.text.trim();
    final amount = double.tryParse(text);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter a valid amount')));
      return;
    }

    provider.updateDonations(amount);
    _donationController.clear();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Thank you for donating')));
  }
}
