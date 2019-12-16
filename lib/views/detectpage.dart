import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:road_hackers/models/sharabledata.dart';
import 'package:road_hackers/models/user_location.dart';
import 'package:road_hackers/services/acceleration_service.dart';
import 'package:road_hackers/services/datanotifier.dart';
import 'package:road_hackers/services/location_service.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

import 'camera.dart';
import 'bndbox.dart';

class DetectPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  final DataNotifier _text;
  DetectPage(this.cameras, this._text);

  @override
  _DetectPageState createState() => new _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";
  CameraController _controller;

  // DetectionNotifier(SharableData("No people detected!", Colors.black));

  @override
  void initState() {
    super.initState();
    loadModel();
    widget._text.changeDectionMsg("No object detected!");
    widget._text.changeDectionColor(Colors.green);
    // print("Speed:" + getSpeed().toString());
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  setController(controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    // loadModel();
    return MultiProvider(
      providers: [
        StreamProvider<UserLocation>.controller(
            builder: (context) => LocationService().locationStream),
        StreamProvider<double>.controller(
            builder: (context) => AccService().accStream)
      ],
      child: Scaffold(
        body: Stack(
          children: [
            Camera(widget.cameras, _model, setRecognitions, setController,
                widget._text),
            BndBox(
              _recognitions == null ? [] : _recognitions,
              math.min(_imageHeight, _imageWidth),
              math.max(_imageHeight, _imageWidth),
              screen.height,
              screen.width,
              _model,
              widget._text,
            ),
            new Positioned(
              child: new Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ValueListenableBuilder(
                    builder: (BuildContext context, SharableData value,
                        Widget child) {
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
                        padding:
                            new EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                      );
                    },
                    valueListenable: widget._text,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  loadModel() async {
    final model =
        (widget._text.getModleAccuracy() == 0.0 ? 'detect' : 'new_detect');
    print(model);
    await Tflite.loadModel(
        model: "assets/$model.tflite", labels: "assets/detect.txt");
    // await Tflite.loadModel(
    //     model: "assets/ssd_mobilenet.tflite",
    //     labels: "assets/ssd_mobilenet.txt");
    _model = "SSD MobileNet";
  }
}
