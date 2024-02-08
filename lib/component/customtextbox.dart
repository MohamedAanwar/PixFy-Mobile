import 'package:flutter/material.dart';

class CustomTextBox extends StatelessWidget {
  final String NameorCode;
  const CustomTextBox({super.key, required this.NameorCode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 37,
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: InkWell(
              onTap: () {},
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10)
                      ]),
                  alignment: Alignment.center,
                  child: Text(
                    NameorCode,
                    style: TextStyle(
                        fontSize: 21,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  )),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
