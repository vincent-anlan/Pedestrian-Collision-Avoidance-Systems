import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:image/image.dart' as Ig;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:provider/provider.dart';
import 'package:road_hackers/services/datanotifier.dart';
import 'package:road_hackers/services/image_converter.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

typedef void Callback(List<dynamic> list, int h, int w);

var rotated;

class Camera extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Callback setRecognitions;
  final String model;
  final setController;
  final DataNotifier _text;
  Camera(this.cameras, this.model, this.setRecognitions, this.setController,
      this._text);
  @override
  _CameraState createState() => new _CameraState();
}

class _CameraState extends State<Camera> {
  CameraController controller;
  bool isDetecting = false;

  @override
  void initState() {
    super.initState();
    int objectsPerFrame = widget._text.value.cacheLimit.round();
    double sensitivity = (0.45 + (widget._text.value.sliderValue - 1) * 0.05);
    // int modleAccuracy = widget._text.getModleAccuracy().round();

    print("sensitivity: " + sensitivity.toString());
    print("objectsPerFrame: " + objectsPerFrame.toString());

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
        // Set controller
        widget.setController(controller);
        controller.startImageStream((CameraImage img) {
          if (!isDetecting) {
            isDetecting = true;
            // int startTime = new DateTime.now().millisecondsSinceEpoch;
            rotated = dealImage(img.planes);
            Tflite.detectObjectOnFrame(
              bytesList: rotated,
              model: "SSDMobileNet",
              imageHeight: img.width,
              imageWidth: img.height,
              imageMean: 128,
              imageStd: 127,
              numResultsPerClass: objectsPerFrame,
              threshold: sensitivity,
            ).then((recognitions) {
              // int endTime = new DateTime.now().millisecondsSinceEpoch;
              // print("Detection took ${endTime - startTime}");
              widget.setRecognitions(recognitions, img.height, img.width);
              final acc = Provider.of<double>(context);
              // if (acc.abs() >= 5 ) takePicture(context, img);
              if (acc.abs() >= 3 && widget._text.isWarning()) takePicture(img);
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

  void takePicture(CameraImage img) {
    convertImagetoPng(img).then((list) {
      ImageGallerySaver.saveImage(list);
    });
  }
}
