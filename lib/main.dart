import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './homepage.dart';
import './detectpage.dart';
import 'videopage.dart';
 Future main() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      '/detect': (context) => DetectPage(),
      '/video': (context) => VideoPage(),
      },
      debugShowCheckedModeBanner: false
    );
  }
}

