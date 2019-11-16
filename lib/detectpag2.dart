import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:road_hackers/dectionnotifier.dart';
import 'package:road_hackers/sensor.dart';
import 'package:road_hackers/sharabledata.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';
import 'models.dart';

class DetectPage2 extends StatefulWidget {
  final List<CameraDescription> cameras;

  DetectPage2(this.cameras);

  @override
  _DetectPage2State createState() => new _DetectPage2State();
}

class _DetectPage2State extends State<DetectPage2> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  final DetectionNotifier _text =
      DetectionNotifier(SharableData("No people detected!", Colors.black));

  @override
  void initState() {
    super.initState();
    loadModel();
    // print("Speed:" + getSpeed().toString());
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    // loadModel();
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
          new Positioned(
            child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: ValueListenableBuilder(
                  builder:
                      (BuildContext context, SharableData value, Widget child) {
                    return new Container(
                      child: new Text(
                        '${value.displayMsg}',
                        softWrap: true,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300),
                      ),
                      color: value.color,
                      padding: new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    );
                  },
                  valueListenable: _text,
                )),
          ),
        ],
      ),
    );
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/detect.tflite", labels: "assets/detect.txt");
    // await Tflite.loadModel(
    //     model: "assets/ssd_mobilenet.tflite",
    //     labels: "assets/ssd_mobilenet.txt");
    _model = "SSD MobileNet";
  }
}
