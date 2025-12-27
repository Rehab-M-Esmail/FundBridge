import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fund_bridge/providers/donationProvider.dart';
import 'package:fund_bridge/reusable-widgets/longButton.dart';
import 'package:fund_bridge/screens/fundpost4.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class FundPostPage3 extends StatefulWidget {
  const FundPostPage3({super.key});

  @override
  State<FundPostPage3> createState() => _FundPostPage3State();
}

class _FundPostPage3State extends State<FundPostPage3> {
  File? image;
  XFile? pickedFile;
  String? persistedImagePath;

  Future<String> _persistFundraiserImage(String sourcePath) async {
    final dir = await getApplicationDocumentsDirectory();
    final fundraiserDir =
        Directory('${dir.path}${Platform.pathSeparator}fundraisers');
    if (!await fundraiserDir.exists()) {
      await fundraiserDir.create(recursive: true);
    }

    final extension = sourcePath.contains('.')
        ? sourcePath.substring(sourcePath.lastIndexOf('.'))
        : '.jpg';
    final destPath =
        '${fundraiserDir.path}${Platform.pathSeparator}fundraiser_${DateTime.now().millisecondsSinceEpoch}$extension';
    final savedFile = await File(sourcePath).copy(destPath);
    return savedFile.path;
  }

  Future pickImage() async {
    final picker = ImagePicker();
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print(pickedFile);
      final savedPath = await _persistFundraiserImage(pickedFile!.path);
      setState(() {
        persistedImagePath = savedPath;
        image = File(savedPath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final donationData = Provider.of<DonationProvider>(context, listen: false);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                "3 of 4",
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
                        icon: Icon(
                          Icons.add,
                          color: Color(0xff02A95C),
                          size: 60,
                        ),
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
                      ],
                    ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.3),
              LongButton(
                text: "Continue",
                action: () {
                  if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "You must pick a fundraiser cover picture",
                        ),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  } else {
                    donationData.setImage(persistedImagePath!);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FundPostPage4()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
