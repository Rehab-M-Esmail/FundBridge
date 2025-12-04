import 'package:flutter/material.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';

class FundPostPage4 extends StatefulWidget {
  const FundPostPage4({super.key});

  @override
  State<FundPostPage4> createState() => _FundPostPage4State();
}

class _FundPostPage4State extends State<FundPostPage4> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              height: MediaQuery.of(context).size.height * 0.05,
              image: AssetImage("imgs/logo.png"),
            ),
            Text(
              "4 of 5",
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
                  "Tell donors why you're fundraising",
                  style: TextStyle(
                    fontSize: 27,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w900,
                    color: Color(0xff333333),
                  ),
                ),
                Text(
                  "Give your fundraiser a title",
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
                keyboardType: TextInputType.text,
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
            ),
            Text(
              "Tell your story",
              style: TextStyle(
                fontSize: 20,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w900,
                color: Color(0xff333333),
              ),
            ),
            Form(
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 12,
                minLines: 8,
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
            ),
            LongButton(text: "Continue", action: () {}),
          ],
        ),
      ),
    );
  }
}
