import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:road_hackers/dectionnotifier.dart';
import 'package:road_hackers/sharabledata.dart';
import 'package:tflite/tflite.dart';

import 'bndbox.dart';
import 'camera.dart';
import 'dart:math' as math;

class DetectPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  DetectPage(this.cameras);

  @override
  _DetectPageState createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  // CameraController controller;
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "SSD MobileNet";
  final DetectionNotifier _text = DetectionNotifier(SharableData("No people detected!", Colors.black));

  @override
  void initState() {
    super.initState();
    // controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    // controller.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // });
  }

  @override
  Future dispose() async {
    // controller?.dispose();
    super.dispose();
    await Tflite.close();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  loadModel() async {
    String res = await Tflite.loadModel(
        model: "assets/detect.tflite", labels: "assets/detect.txt");
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    print(screen.height);
    print(screen.width);
    // if (!controller.value.isInitialized) {
    //   return Container();
    // }
    loadModel();
    // return Row(children: [
    //   RotatedBox(
    //       quarterTurns: 3,
    //       // child: AspectRatio(
    //       //   aspectRatio:
    //       //   controller.value.aspectRatio,
    //       //   child: CameraPreview(controller))
    //       child: Stack(
    //         children: [
    //           Camera(
    //             widget.cameras,
    //             _model,
    //             setRecognitions,
    //           ),
    //           BndBox(
    //               _recognitions == null ? [] : _recognitions,
    //               math.max(_imageHeight, _imageWidth),
    //               math.min(_imageHeight, _imageWidth),
    //               screen.height,
    //               screen.width,
    //               _model),
    //         ],
    //       )),
    //   Expanded(
    //       child: Container(
    //     width: 40,
    //     color: Colors.green,
    //   ))
    // ]);
    // SystemChrome.setEnabledSystemUIOverlays([]); //full screen
    return Scaffold(
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          BndBox(
            _recognitions == null ? [] : _recognitions,
            math.max(_imageHeight, _imageWidth),
            math.min(_imageHeight, _imageWidth),
            screen.height,
            screen.width,
            _model,
            _text,
          ),
        ],
      ),
    );
  }
}
