import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:pixfyapp/save.dart';

class ProcessingScreen extends StatefulWidget {
  final img.Image original;

  const ProcessingScreen({Key? key, required this.original}) : super(key: key);

  @override
  _ProcessingState createState() => _ProcessingState();
}

class _ProcessingState extends State<ProcessingScreen> {
  img.Image? processedImage;
  img.Image? displayImage;
  bool isloading = false;
  bool isloading1 = false;

  @override
  void initState() {
    super.initState();
    displayImage = widget.original;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PixFy',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0462ff),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.restore),
            color: Colors.white,
          ),
          isloading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 5,
                  ),
                )
              : IconButton(
                  onPressed: () async {
                    isloading = true;
                    setState(() {});
                    await Future.delayed(Duration(seconds: 2));
                    Navigator.push(
                        (context),
                        MaterialPageRoute(
                            builder: (context) => SaveImage(
                                  procimage: widget.original,
                                )));
                    isloading = false;
                    setState(() {});
                  },
                  icon: Icon(Icons.check),
                  color: Colors.white,
                ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(children: [
              displayImage != null
                  ? Image.memory(
                      Uint8List.fromList(img.encodeJpg(displayImage!)))
                  : Image.asset(
                      "assets/images/noimage.jpg",
                      width: 400,
                      height: 350,
                    ),
            ]),
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Container(
          color: Colors.blue,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              InkWell(
                onTap: () async {
                  isloading1 = true;
                  setState(() {});
                  await gaussianBlur(widget.original, radius: 5);
                  isloading1 = false;
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      isloading1
                          ? Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 6,
                                color: Colors.white,
                              ),
                            )
                          : Icon(
                              Icons.filter_1,
                              color: Colors.white,
                            ),
                      SizedBox(height: 4),
                      Text(
                        'Gaussian Blur',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  grayscale(widget.original);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_2,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Grayscale',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  edgeGlow(widget.original, amount: 1.0);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_3,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Edge Glow',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  emboss(widget.original, amount: 1.0);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_4,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Emboss',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  gamma(widget.original, gamma: 1.5);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_5,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Gamma',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  noise(widget.original, sigma: 20.0);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_6,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Noise',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  normalize(widget.original, min: 0, max: 255);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_7,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Normalize',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  smooth(widget.original, weight: 1.0);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_8,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Smooth',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  scale(widget.original, width: 300, height: 300);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_9,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Scale',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  invertColors(widget.original);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_1,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Invert Colors',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  sepia(widget.original);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_2,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Sepia',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  luminanceThreshold(widget.original, threshold: 0.5);
                  setState(() {});
                },
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.filter_3,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text('Threshold',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  img.Image gaussianBlur(img.Image inputImage, {required int radius}) {
    return img.gaussianBlur(inputImage, radius: radius);
  }

  img.Image grayscale(img.Image inputImage) {
    return img.grayscale(inputImage);
  }

  img.Image edgeGlow(img.Image inputImage, {num amount = 1.0}) {
    return img.edgeGlow(inputImage, amount: amount);
  }

  img.Image emboss(img.Image inputImage, {num amount = 1.0}) {
    return img.emboss(inputImage, amount: amount);
  }

  img.Image gamma(img.Image inputImage, {required double gamma}) {
    return img.gamma(inputImage, gamma: gamma);
  }

  img.Image noise(img.Image inputImage, {required double sigma}) {
    return img.noise(inputImage, sigma, type: img.NoiseType.gaussian);
  }

  img.Image luminanceThreshold(img.Image inputImage, {num threshold = 0.5}) {
    return img.luminanceThreshold(inputImage, threshold: threshold);
  }

  img.Image normalize(img.Image inputImage,
      {required int min, required int max}) {
    return img.normalize(inputImage, min: min, max: max);
  }

  img.Image smooth(img.Image inputImage, {required double weight}) {
    return img.smooth(inputImage, weight: weight);
  }

  img.Image scale(img.Image inputImage,
      {required int width, required int height}) {
    return img.copyResize(inputImage, width: width, height: height);
  }

  img.Image invertColors(img.Image inputImage) {
    return img.invert(inputImage);
  }

  img.Image sepia(img.Image inputImage) {
    return img.sepia(inputImage);
  }
}
