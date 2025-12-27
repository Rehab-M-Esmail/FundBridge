import 'package:flutter/material.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';
import 'package:fund_bridge/services/donations.dart';

class donate extends StatefulWidget {
  final int? campaignId;
  final Map<String, dynamic>? campaignData;

  const donate({super.key, this.campaignId, this.campaignData});

  @override
  State<donate> createState() => _donateState();
}

class _donateState extends State<donate> with TickerProviderStateMixin {
  TextEditingController amountController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  String selectedCurrency = 'EGP';
  String selectedPayment = 'Debit Card';
  bool isAnonymous = false;

  Map<String, dynamic>? campaign;
  int raisedAmount = 0;
  bool isLoading = true;
  final DonationsService donationsService = DonationsService();

  late AnimationController _contentController;
  late Animation<double> _contentAnimation;

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _contentAnimation = CurvedAnimation(
      parent: _contentController,
      curve: Curves.easeOut,
    );
    loadCampaignData();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Future<void> loadCampaignData() async {
    if (widget.campaignData != null) {
      setState(() {
        campaign = widget.campaignData;
        raisedAmount = campaign!['currentAmount'] ?? 0;
        isLoading = false;
      });
      _contentController.forward();
    } else if (widget.campaignId != null) {
      final data = await donationsService.getDonationById(widget.campaignId!);
      final raised =
          await donationsService.getTotalRaisedAmount(widget.campaignId!);
      setState(() {
        campaign = data;
        raisedAmount = raised;
        isLoading = false;
      });
      _contentController.forward();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadRaisedAmount() async {
    if (campaign != null && campaign!['id'] != null) {
      final raised =
          await donationsService.getTotalRaisedAmount(campaign!['id']);
      setState(() {
        raisedAmount = raised;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(color: Color(0xff008748)),
        ),
      );
    }

    if (campaign == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 60, color: Color(0xff767676)),
              SizedBox(height: 20),
              Text(
                "No campaign selected",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w700,
                  color: Color(0xff333333),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          30,
          MediaQuery.of(context).size.height * 0.05,
          30,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: SingleChildScrollView(
          child: FadeTransition(
            opacity: _contentAnimation,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'app_logo',
                  child: Image(
                    height: MediaQuery.of(context).size.height * 0.05,
                    image: AssetImage("imgs/logo.png"),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ScaleTransition(
                    scale: _contentAnimation,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xff008748),
                      child: Icon(Icons.person, size: 40, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Hero(
                  tag: 'fund_image_${campaign!['id']}',
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xffE8E8E8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: campaign!['image'] != null &&
                              campaign!['image'] != ''
                          ? Image.network(
                              campaign!['image'],
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.image,
                                    size: 60, color: Color(0xff767676));
                              },
                            )
                          : Icon(Icons.image, size: 60, color: Color(0xff767676)),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  campaign!['title'] ?? "Campaign Title",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w900,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 10),
                AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Color(0xff008748).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Raised: \$${raisedAmount.toString()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w800,
                          color: Color(0xff008748),
                        ),
                      ),
                      Text(
                        "Goal: \$${campaign!['donationGoal']?.toString() ?? '0'}",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w800,
                          color: Color(0xff333333),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  campaign!['description'] ?? "No description available.",
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w600,
                    color: Color(0xff767676),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Amount",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter amount",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DropdownButton<String>(
                        value: selectedCurrency,
                        isExpanded: true,
                        items: ['USD', 'EUR', 'KWD', 'EGP'].map((currency) {
                          return DropdownMenuItem(
                            value: currency,
                            child: Text(currency),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCurrency = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  "Payment Method",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedPayment,
                  isExpanded: true,
                  items:
                      ['Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer']
                          .map((method) {
                    return DropdownMenuItem(
                      value: method,
                      child: Text(method),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPayment = value!;
                    });
                  },
                ),
                SizedBox(height: 15),
                CheckboxListTile(
                  title: Text(
                    "Donate Anonymously",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w700,
                      color: Color(0xff333333),
                    ),
                  ),
                  value: isAnonymous,
                  activeColor: Color(0xff008748),
                  onChanged: (value) {
                    setState(() {
                      isAnonymous = value!;
                    });
                  },
                ),
                SizedBox(height: 15),
                Text(
                  "Comment",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.w800,
                    color: Color(0xff333333),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: commentController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Leave a message...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                LongButton(
                  text: "Donate",
                  action: () async {
                    if (amountController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter donation amount'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    double amount = double.tryParse(amountController.text) ?? 0;
                    if (amount <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter valid amount'),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }

                    try {
                      await donationsService.saveDonation(
                        campaignId: campaign!['id'],
                        donorId: 1, // TODO: Get from user session/auth
                        amount: amount,
                        currency: selectedCurrency,
                        paymentMethod: selectedPayment,
                        isAnonymous: isAnonymous,
                        comment: commentController.text,
                      );

                      await loadRaisedAmount();

                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Text('Success!'),
                          content: Text(
                              'Thank you for your donation of $amount $selectedCurrency!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                amountController.clear();
                                commentController.clear();
                                setState(() {
                                  isAnonymous = false;
                                });
                              },
                              child: Text('OK',
                                  style: TextStyle(color: Color(0xff008748))),
                            ),
                          ],
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error processing donation: $e'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
