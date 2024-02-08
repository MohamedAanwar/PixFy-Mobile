import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveImage extends StatefulWidget {
  final img.Image procimage;

  const SaveImage({super.key, required this.procimage});

  @override
  State<SaveImage> createState() => _SaveImageState();
}

class _SaveImageState extends State<SaveImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filtered Image',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0462ff),
        actions: [],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
                child: Image.memory(
                    Uint8List.fromList(img.encodeJpg(widget.procimage!)))),
          ),
          Text(
            "Thank You!",
            style: TextStyle(
                fontSize: 35,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w900,
                color: Color(0xFF0462ff)),
          ),
          SizedBox(height: 1),
          Container(
            width: 360,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Edit done successfuly",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Column(
            children: [],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFF0462ff)),
                onPressed: () {
                  save(widget.procimage);
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.rightSlide,
                    title: 'Successful',
                    desc: 'The image saved successfuly',
                    btnOkOnPress: () {
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil("home", (route) => false);
                    },
                  ).show();
                },
                child: Text(
                  'Save Image',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Lato'),
                ),
              ),
              Container(
                width: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color(0xFF0462ff)),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("home", (route) => false);
                },
                child: Text(
                  'Back to home',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Lato'),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

void save(image) async {
  Uint8List bytes = Uint8List.fromList(img.encodeJpg(image));
  await ImageGallerySaver.saveImage(bytes);
}
