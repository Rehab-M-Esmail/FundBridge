import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final String text;
  final VoidCallback action;
  const LongButton({Key? key, required this.text, required this.action})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xff008748)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        fixedSize: MaterialStateProperty.all(
          Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height * 0.08,
          ),
        ),
      ),
      onPressed: action,
      child: Text(
        "${text}",
        style: TextStyle(
          color: Color(0xffffffff),
          fontSize: 25,
          fontFamily: "Poppins",
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
