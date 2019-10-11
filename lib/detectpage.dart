import 'package:flutter/material.dart';

import 'package:camera/camera.dart';



class DetectPage extends StatefulWidget {
  final List<CameraDescription> cameras;
  DetectPage(this.cameras);



  @override
  _DetectPageState createState() => _DetectPageState();
}

class _DetectPageState extends State<DetectPage> {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Row(
      children:[
        RotatedBox(
            quarterTurns: 3,
            child: AspectRatio(
              aspectRatio:
              controller.value.aspectRatio,
              child: CameraPreview(controller))
        ),
        Expanded(
          child: Container(
            width: 40,
            color: Colors.green,
          )
        )
      ]
    );
  }
}