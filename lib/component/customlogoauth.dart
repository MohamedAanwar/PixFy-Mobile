import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 120,
          height: 120,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Color(0xFFf6f6ff),
              borderRadius: BorderRadius.circular(70)),
          child: Image.asset(
            "assets/images/logoo.png",
            width: 40,
            height: 40,
          )),
    );
  }
}
