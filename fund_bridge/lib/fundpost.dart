import 'package:flutter/material.dart';
import 'common_appbar.dart';

class fundpost extends StatefulWidget {
  const fundpost({super.key});

  @override
  State<fundpost> createState() => _FundPostState();
}

class _FundPostState extends State<fundpost> {
  bool isStarred = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(title: 'Fund Post'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Main Image with flag and side icons ===
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // Small flag icon
                Positioned(
                  top: 10,
                  right: 10,
                  child: IconButton(
                    icon: const Icon(Icons.flag, color: Color.fromARGB(255, 0, 0, 0)),
                    onPressed: () {},
                  ),
                ),
                // Side icons (star, share, repost)
                Positioned(
                  right: 10,
                  top: 60,
                  child: Column(
                    children: [
                      IconButton(
                        icon: Icon(
                          isStarred ? Icons.star : Icons.star_border,
                          color: isStarred ? Colors.amber : Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            isStarred = !isStarred;
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share, color: Colors.black),
                        onPressed: () {},
                      ),
                      IconButton(
                        icon: const Icon(Icons.block, color: Colors.black),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // === Fund Button ===
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Fund',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // === Fund Title ===
            const Text(
              'Fund Title',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // === Fund Brief ===
            const Text(
              'blaaaa bla bla.',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16),

            // === Progress bar and raised amount ===
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                    minHeight: 10,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  '\$5,200',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // === Horizontal Image Scroller ===
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 12,
                itemBuilder: (context, index) => Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // === Details ===
            const Text(
              'Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'extra bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla bla ',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),

            const SizedBox(height: 24),

            // === Top Donors ===
            const Text(
              'Top Donations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _DonationBar(amount: 300),
                _DonationBar(amount: 200),
                _DonationBar(amount: 150),
              ],
            ),

            const SizedBox(height: 10),

            // === Comments Section ===
            const Text(
              'Comments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            Column(
              children: List.generate(
                3,
                (index) => _CommentTile(
                  name: 'User $index',
                  comment: 'This is a dumb idea',
                  amount: 500,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // === More Comments Button ===
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('More'),
              ),
            ),

            const SizedBox(height: 16),

            // === Fund Button again ===
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                ),
                child: const Text(
                  'Fund',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// === Small widgets used above ===

class _DonationBar extends StatelessWidget {
  final int amount;
  const _DonationBar({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: amount / 2,
          width: 30,
          color: const Color.fromARGB(255, 255, 177, 118),
        ),
        const SizedBox(height: 6),
        Text('\$$amount'),
      ],
    );
  }
}

class _CommentTile extends StatelessWidget {
  final String name;
  final String comment;
  final int amount;

  const _CommentTile({
    required this.name,
    required this.comment,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.grey,
        ),
        title: Text(name),
        subtitle: Text(comment),
        trailing: Text(
          '\$$amount',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
