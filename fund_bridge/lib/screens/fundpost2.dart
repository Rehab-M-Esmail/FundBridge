import 'package:flutter/material.dart';
import 'package:fund_bridge/providers/donationProvider.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';
import 'package:fund_bridge/screens/fundpost3.dart';
import 'package:provider/provider.dart';

class FundPostPage2 extends StatefulWidget {
  const FundPostPage2({super.key});

  @override
  State<FundPostPage2> createState() => _FundPostPage2State();
}

class _FundPostPage2State extends State<FundPostPage2> {
  TextEditingController goalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final donationData = Provider.of<DonationProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          30,
          MediaQuery.of(context).size.height * 0.05,
          30,
          MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              height: MediaQuery.of(context).size.height * 0.05,
              image: AssetImage("imgs/logo.png"),
            ),
            Text(
              "2 of 5",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "How much would you like to raise?",
                  style: TextStyle(
                    fontSize: 27,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900,
                    color: Color(0xff333333),
                  ),
                ),
                Text(
                  "You can always change your goal as you go",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900,
                    color: Color(0xff767676),
                  ),
                ),
              ],
            ),
            Form(
              child: TextFormField(
                controller: goalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.attach_money, color: Colors.black),
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
            ),
            Text(
              "Keep in mind that transaction fees, including credit card and debit charges, are deducted from each donation",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w900,
                color: Color(0xff767676),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffE7F0F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "To recieve money raised, make sure the person withdrawing has:\n\nA US social security number\nA bank account and mailing address in one of the 50 states",
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontFamily: "Poppins",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            LongButton(
              text: "Continue",
              action: () {
                donationData.setGoal(int.parse(goalController.text));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FundPostPage3()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
