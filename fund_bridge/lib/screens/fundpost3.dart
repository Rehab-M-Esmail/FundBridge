import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fund_bridge/providers/donationProvider.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';
import 'package:fund_bridge/screens/fundpost4.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class FundPostPage3 extends StatefulWidget {
  const FundPostPage3({super.key});

  @override
  State<FundPostPage3> createState() => _FundPostPage3State();
}

class _FundPostPage3State extends State<FundPostPage3> {
  File? image;
  dynamic pickedFile;
  Future pickImage() async {
    final picker = ImagePicker();
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print(pickedFile);
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final donationData = Provider.of<DonationProvider>(context, listen: false);
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
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                color: Color(0xff333333),
              ),
            ),
            SizedBox(height: 25),

            Text(
              "Add a cover photo",
              style: TextStyle(
                fontSize: 27,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w900,
                color: Color(0xff333333),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Using a bright and clear photo helps people connect to your fundraiser right away",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                color: Color(0xff767676),
              ),
            ),
            SizedBox(height: 40),
            image == null
                ? Center(
                    child: IconButton(
                      onPressed: () {
                        pickImage();
                      },
                      icon: Icon(Icons.add, color: Color(0xff02A95C), size: 60),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            image!,
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.3,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            color: Color(0xff0D4715),
                            onPressed: () {},
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            color: Color(0xff0D4715),
                            onPressed: () {},
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
            Spacer(),
            LongButton(
              text: "Continue",
              action: () {
                donationData.setImage(pickedFile.path!);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FundPostPage4()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
