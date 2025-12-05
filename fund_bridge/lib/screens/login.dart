import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fund_bridge/services/userService.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPasswordVisible = true;
  String? loginStatus;
  UserService userService = UserService();

  void toggleVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          26,
          MediaQuery.of(context).size.height * 0.07,
          26,
          20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back \nTo Fund Bridge!",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff0D4715),
                  ),
                ),
              ],
            ),
            Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 18, 0, 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Email address",
                        style: TextStyle(
                          color: Color(0xff6B8A88),
                          fontFamily: "Poppins",
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: email,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter an email";
                      }
                    },
                    style: TextStyle(
                      color: Color(0xff0D4715),
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xffF1F0E9),
                      isDense: true,
                      prefixIcon: Icon(FontAwesomeIcons.envelope, size: 20),
                      prefixIconColor: Color(0xff0D4715),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 18, 0, 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Password",
                        style: TextStyle(
                          color: Color(0xff6B8A88),
                          fontFamily: "Poppins",
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  TextFormField(
                    obscureText: isPasswordVisible,
                    controller: password,
                    validator: (value) {
                      if (value!.length < 6) {
                        return "Password length must be at least 6 characters";
                      }
                    },
                    style: TextStyle(
                      color: Color(0xff0D4715),
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Color(0xffF1F0E9),
                      prefixIcon: Icon(FontAwesomeIcons.lock, size: 20),
                      prefixIconColor: Color(0xff0D4715),
                      suffixIcon: IconButton(
                        onPressed: toggleVisibility,
                        icon: Icon(
                          isPasswordVisible
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                        ),
                      ),
                      suffixIconColor: Colors.lightGreen,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 16),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 33, 185, 96),
                      Color.fromARGB(255, 0, 255, 132),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    final user = await userService.userLogin(
                      email.text,
                      password.text,
                    );
                    if (user != null) {
                      Navigator.pushNamed(context, "/");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("User does not exist"),
                          backgroundColor: Colors.red,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 2, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account yet? ",
                    style: TextStyle(
                      color: Color(0xff6B8A88),
                      fontFamily: "Poppins",
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: Color(0xff007AFF),
                        fontFamily: "Poppins",
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "/signup");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
