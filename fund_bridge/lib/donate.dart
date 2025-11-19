import 'package:flutter/material.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';

class donate extends StatefulWidget {
  const donate({super.key});

  @override
  State<donate> createState() => _donateState();
}

class _donateState extends State<donate> {
  TextEditingController amountController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  String selectedCurrency = 'EGP';
  String selectedPayment = 'Debit Card';
  bool isAnonymous = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          30,
          MediaQuery.of(context).size.height * 0.05,
          30,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                height: MediaQuery.of(context).size.height * 0.05,
                image: AssetImage("imgs/logo.png"),
              ),
              SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xff008748),
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xffE8E8E8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: AssetImage("../imgs/rural_areas.jpg"),
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Help Build a School",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w900,
                  color: Color(0xff333333),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Color(0xff008748).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Raised: \$25,000",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.w800,
                        color: Color(0xff008748),
                      ),
                    ),
                    Text(
                      "Goal: \$50,000",
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
                "Building a school for children in rural areas to provide better education opportunities.",
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
                items: ['Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer']
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
                action: () {
                  // Donation logic here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
