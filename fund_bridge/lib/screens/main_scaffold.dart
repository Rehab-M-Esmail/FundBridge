import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_bridge/homepage.dart';
import 'package:fund_bridge/screens/fundpost.dart';
import 'package:fund_bridge/screens/login.dart';
import 'package:fund_bridge/screens/signup.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  List pages = [MyHomePage(), FundPostPage1(), Login()];
  int index = 0;
  bool isLoaded = false;

  void onTapped(int tappedIndex) {
    setState(() {
      index = tappedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoaded = true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoaded ? CupertinoActivityIndicator() : pages[index],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Material(
            elevation: 10,
            shadowColor: Colors.black26,
            child: GNav(
              iconSize: 20,
              backgroundColor: Color(0xffE8F3EC),
              selectedIndex: index,
              color: Color(0xff0D4715),
              tabBackgroundColor: Colors.white70,
              tabBorderRadius: 20,
              activeColor: Colors.black,
              duration: Duration(milliseconds: 900),
              haptic: true,
              gap: 8,
              onTabChange: (indexInput) {
                setState(() {
                  index = indexInput;
                });
              },
              tabs: [
                GButton(icon: FontAwesomeIcons.house),
                GButton(icon: FontAwesomeIcons.heart),
                GButton(icon: FontAwesomeIcons.user),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
