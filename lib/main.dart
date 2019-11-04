import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './homepage.dart';
import './detectpage.dart';
import './detectpag2.dart';
import 'videopage.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future main() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  cameras = await availableCameras();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        routes: {
          // '/': (context) => HomePage(),
          '/detect': (context) => DetectPage2(cameras),
          '/video': (context) => VideoPage(),
        },
        debugShowCheckedModeBanner: false);
  }
}
