import 'package:flutter/material.dart';
import 'package:pixfyapp/component/ourteamimage.dart';
import 'package:pixfyapp/component/customtextbox.dart';

class Info extends StatefulWidget {
  const Info({super.key});

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Color(0xFF0462ff),
                title: Text(
                  "Our Team",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                height: 5,
              ),
              OurTeam(image: "assets/images/OIP.jpeg"),
              CustomTextBox(NameorCode: "Mohamed Anwar Mohamed"),
              Container(
                height: 5,
              ),
              CustomTextBox(NameorCode: "210900096"),
              Container(
                height: 5,
              ),
              OurTeam(image: "assets/images/OIP.jpeg"),
              CustomTextBox(NameorCode: "Mohamed Saeed Goda"),
              Container(
                height: 5,
              ),
              CustomTextBox(NameorCode: "210900013"),
              Container(
                height: 5,
              ),
              OurTeam(image: "assets/images/OIP.jpeg"),
              CustomTextBox(NameorCode: "Mohamed Gharib Yassen"),
              Container(
                height: 5,
              ),
              CustomTextBox(NameorCode: "210900041"),
              Container(
                height: 5,
              ),
              OurTeam(image: "assets/images/OIP.jpeg"),
              CustomTextBox(NameorCode: "Ahmed Gharib Mansour"),
              Container(
                height: 5,
              ),
              CustomTextBox(NameorCode: "210900015"),
              Container(
                height: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
