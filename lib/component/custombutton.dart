import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String hinttext;
  const CustomButton({super.key, required this.hinttext, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      color: Color(0xFF0462ff),
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(
        hinttext,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w900, fontFamily: 'Lato'),
      ),
    );
  }
}
