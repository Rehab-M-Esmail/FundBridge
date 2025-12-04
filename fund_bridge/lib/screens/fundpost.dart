import 'package:flutter/material.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';
import 'package:fund_bridge/screens/fundpost2.dart';

class FundPostPage1 extends StatefulWidget {
  const FundPostPage1({super.key});

  @override
  State<FundPostPage1> createState() => _FundPostPage1State();
}

class _FundPostPage1State extends State<FundPostPage1> {
  @override
  List<bool> isChosen = [false, false, false];
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
              "1 of 5",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            Text(
              "Tell us who you are raising funds for",
              style: TextStyle(
                fontSize: 27,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w900,
                color: Color(0xff333333),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  for (int i = 0; i < isChosen.length; i++) {
                    isChosen[i] = i == 0 ? !isChosen[0] : false;
                  }
                });
              },
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isChosen[0]
                            ? Color(0xff008748)
                            : Color(0xff767676),
                        width: isChosen[0] ? 2 : 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            height: MediaQuery.of(context).size.height * 0.13,
                            image: AssetImage("imgs/Frame.png"),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Yourself",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20,
                                  color: Color(0xff333333),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Funds are delivered to your \nbank account"
                                " for your own use",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Color(0xff333333),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  for (int i = 0; i < isChosen.length; i++) {
                    isChosen[i] = i == 1 ? !isChosen[1] : false;
                  }
                });
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isChosen[1] ? Color(0xff008748) : Color(0xff767676),
                    width: isChosen[1] ? 2 : 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        height: MediaQuery.of(context).size.height * 0.13,
                        image: AssetImage("imgs/hug.png"),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Someone else",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Color(0xff333333),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "You will recieve a beneficiary to \nrecieve funds or distribute them",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  for (int i = 0; i < isChosen.length; i++) {
                    isChosen[i] = i == 2 ? !isChosen[2] : false;
                  }
                });
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.14,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isChosen[2] ? Color(0xff008748) : Color(0xff767676),
                    width: isChosen[2] ? 2 : 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        height: MediaQuery.of(context).size.height * 0.13,
                        image: AssetImage("imgs/charity.png"),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Charity",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                              color: Color(0xff333333),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Funds are delivered to your \nchosen nonprofit for you",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: Color(0xff333333),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            LongButton(
              text: "Continue",
              action: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FundPostPage2(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
