import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:camera/camera.dart';
import 'package:road_hackers/views/detectpage.dart';
import 'package:road_hackers/views/gallery.dart';
import 'package:road_hackers/views/homepage.dart';

List<CameraDescription> cameras;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeRight]);
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
          '/detect': (context) => DetectPage(cameras),
          '/gallery': (context) => Gallery(),
        },
        debugShowCheckedModeBanner: false);
  }
}
