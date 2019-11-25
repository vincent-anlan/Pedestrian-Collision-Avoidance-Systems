import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:image/image.dart' as Ig;
import 'package:tflite/tflite.dart';
import 'dart:math' as math;
import 'models.dart';

typedef void Callback(List<dynamic> list, int h, int w);

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;

  Camera(this.cameras, this.model, this.setRecognitions);

  @override
  _CameraState createState() => new _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();

    if (widget.cameras == null || widget.cameras.length < 1) {
      print('No camera is found');
    } else {
      controller = new CameraController(
        widget.cameras[0],
        ResolutionPreset.high,
      );
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});

        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;
            int startTime = new DateTime.now().millisecondsSinceEpoch;
            // print(img.height);
            Tflite.detectObjectOnFrame(
              // bytesList: img.planes.map((plane) {
              //   return plane.bytes;
              // }).toList(),
              bytesList: dealImage(img.planes),
              model: "SSDMobileNet",
              imageHeight: img.width,
              imageWidth: img.height,
              imageMean: 127.5,
              imageStd: 127.5,
              numResultsPerClass: 6,
              threshold: 0.55,
            ).then((recognitions) {
              int endTime = new DateTime.now().millisecondsSinceEpoch;
              // print("Detection took ${endTime - startTime}");

              widget.setRecognitions(recognitions, img.height, img.width);

              isDetecting = false;
            });
          }
        });
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller.value.isInitialized) {
      return Container();
    }

    var tmp = MediaQuery.of(context).size;
    var screenH = math.min(tmp.height, tmp.width);
    var screenW = math.max(tmp.height, tmp.width);
    tmp = controller.value.previewSize;
    var previewH = math.min(tmp.height, tmp.width);
    var previewW = math.max(tmp.height, tmp.width);
    var screenRatio = screenH / screenW;
    var previewRatio = previewH / previewW;

    return RotatedBox(
      quarterTurns: Platform.isAndroid ? 1 : 3,
      child: OverflowBox(
        maxHeight: screenRatio > previewRatio
            ? screenH / previewH * previewW
            : screenW,
        maxWidth: screenRatio > previewRatio
            ? screenH
            : screenW / previewW * previewH,
        child: CameraPreview(controller),
      ),
    );
  }

  dealImage(List<Plane> planes) {
    return planes.map((plane) {
      // print(Ig.copyRotate(Ig.Image.fromBytes(1080, 720, plane.bytes), 90)
      //     .getBytes());
      if (Platform.isAndroid)
        return Ig.copyRotate(
                Ig.Image.fromBytes(plane.width, plane.height, plane.bytes), 0)
            .getBytes();
      else
        return Ig.copyRotate(
                Ig.Image.fromBytes(plane.width, plane.height, plane.bytes), 270)
            .getBytes();
    }).toList();
  }
}
