import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pixfyapp/auth/login.dart';
import 'package:pixfyapp/homescreen.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => (FirebaseAuth.instance.currentUser != null &&
                  FirebaseAuth.instance.currentUser!.emailVerified)
              ? HomeScreen()
              : Login()));
    });
    return Scaffold(
      backgroundColor: Color(0xFF0462ff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logoo.png",
                    width: 120,
                    height: 120,
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    "Welcome In PixFy",
                    style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
