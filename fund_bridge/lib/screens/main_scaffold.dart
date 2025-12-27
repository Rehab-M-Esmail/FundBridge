import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_bridge/screens/home.dart';
import 'package:fund_bridge/screens/fundpost.dart';
import 'package:fund_bridge/screens/login.dart';
import 'package:fund_bridge/screens/profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  List<Widget> pages = [Home(), FundPostPage1(), Login()];
  int index = 0;
  bool isLoaded = false;
  final storage = FlutterSecureStorage();

  void onTapped(int tappedIndex) {
    setState(() {
      index = tappedIndex;
    });
  }

  Future<void> loadUser() async {
    final userId = await storage.read(key: 'USER_ID');
    if (!mounted) return;
    setState(() {
      final isLoggedIn = userId != null && userId.isNotEmpty && userId != 'null';
      if (isLoggedIn) {
<<<<<<< HEAD
        pages = [Home(), FundPostPage1(), ProfilePage()];
=======
        pages = [Home(), FundPostPage1(), donate()];
>>>>>>> 290987a79a178dab5398c7e9e23dd9539feb90d2
      } else {
        pages = [Home(), FundPostPage1(), Login()];
      }
      isLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !isLoaded
          ? Center(child: CupertinoActivityIndicator())
          : AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: pages[index],
            ),
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
                GButton(
                  icon: FontAwesomeIcons.house,
                  text: 'Home',
                ),
                GButton(
                  icon: FontAwesomeIcons.heart,
                  text: 'Fund',
                ),
                GButton(
                  icon: FontAwesomeIcons.user,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
