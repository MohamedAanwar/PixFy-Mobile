import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:pixfyapp/processingscreen.dart';
import 'package:pixfyapp/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  bool isloading = false;
  bool dorl = false;
  img.Image? originalImage;
  img.Image? processedImage;

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PixFy',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0462ff),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                dorl = !dorl;
              });
              provider.toggleTheme();
            },
            icon: Icon(dorl ? Icons.dark_mode : Icons.light_mode),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed("info");
            },
            icon: Icon(Icons.info),
            color: Colors.white,
          ),
          IconButton(
            color: Colors.white,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              AwesomeDialog(
                context: context,
                dialogType: DialogType.info,
                animType: AnimType.rightSlide,
                title: 'Warning',
                desc: 'Do you want to log out?',
                btnCancelOnPress: () {},
                btnOkOnPress: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("login", (route) => false);
                },
              ).show();
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              child: Image.asset(
                "assets/images/upload.jpg",
              ),
            ),
          ),
          Text(
            "Upload Image",
            style: TextStyle(
                fontSize: 35,
                fontFamily: 'Lato',
                fontWeight: FontWeight.w900,
                color: Colors.blue),
          ),
          SizedBox(height: 10),
          Container(
            width: 360,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Browse and choose the image you want to upload...!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          SizedBox(height: 130),
          Column(
            children: [
              Container(
                width: 100,
                height: 75,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: IconButton(
                    onPressed: () async {
                      await _pickImage();
                    },
                    icon: isloading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 10,
                            ),
                          )
                        : Icon(
                            Icons.add_a_photo_sharp,
                            color: Colors.white,
                            size: 40,
                          )),
              )
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        children: [
          ListTile(
            leading: Icon(Icons.photo_camera),
            title: Text('Take a picture'),
            onTap: () async {
              Navigator.pop(context);
              await _captureImage();
            },
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Choose from the gallery'),
            onTap: () async {
              Navigator.pop(context);
              await _selectImage();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _captureImage() async {
    final XFile? capturedFile =
        await _picker.pickImage(source: ImageSource.camera);
    if (capturedFile != null) {
      await _cropImage(File(capturedFile.path));
    }
  }

  Future<void> _selectImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await _cropImage(File(pickedFile.path));
    }
  }

  Future<void> _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imgFile.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
    );

    if (croppedFile != null) {
      originalImage =
          img.decodeImage(Uint8List.fromList(await croppedFile.readAsBytes()));
      setState(() {});
      isloading = true;
      setState(() {});
      await Future.delayed(Duration(seconds: 2));
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProcessingScreen(
                    original: originalImage!,
                  )));
      isloading = false;
      setState(() {});
    }
  }
}
