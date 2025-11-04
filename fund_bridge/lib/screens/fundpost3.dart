import 'package:flutter/material.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';

class FundPostPage3 extends StatefulWidget {
  const FundPostPage3({super.key});

  @override
  State<FundPostPage3> createState() => _FundPostPage3State();
}

class _FundPostPage3State extends State<FundPostPage3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: MediaQuery.of(context).size.height * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              height: MediaQuery.of(context).size.height * 0.05,
              image: AssetImage("imgs/logo.png"),
            ),
            SizedBox(height: 25),
            Text(
              "3 of 5",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            SizedBox(height: 25),

            Text(
              "Add a cover photo",
              style: TextStyle(
                fontSize: 27,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w900,
                color: Color(0xff333333),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Using a bright and clear photo helps people connect to your fundraiser right away",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
                color: Color(0xff767676),
              ),
            ),
            SizedBox(height: 40),

            // ✅ Add photo button
            Center(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.add, color: Color(0xff02A95C), size: 60),
              ),
            ),
            Spacer(),
            LongButton(text: "Continue", action: () {}),
          ],
        ),
      ),
    );
  }
}
