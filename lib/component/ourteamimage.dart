import 'package:flutter/material.dart';

class OurTeam extends StatelessWidget {
  final String image;
  const OurTeam({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          width: 100,
          height: 100,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
              color: Color(0xFFf6f6ff),
              borderRadius: BorderRadius.circular(70)),
          child: ClipOval(
            child: Image.asset(
              image,
              width: 30,
              height: 30,
            ),
          )),
    );
  }
}
