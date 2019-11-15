import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String value = "";
  bool isCAMSwitched = true;
  double _sliderValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Setting'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Sensility'),
              trailing: Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newRating) {
                    setState(() => _sliderValue = newRating);
                  },
                  value: _sliderValue,
                ),
              
            ),
            ListTile(
              title: Text('CACHE LIMIT (MB)'),
              trailing: TextField(
                onChanged: (text) {
                  value = text;
                },
              )
            ),
            ListTile(
              title: Text('DASH CAM'),
              trailing: Switch(
                value: isCAMSwitched,
                onChanged: (value) {
                  setState(() {
                    isCAMSwitched = value;
                  });
                },
              activeTrackColor: Colors.lightBlueAccent, 
              activeColor: Colors.blue,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          brightness: Brightness.light,
          title: Text("demo"),
          actions: [
            IconButton(
              icon: Icon(Icons.ondemand_video),
              onPressed: () {
                Navigator.pushNamed(context, '/video');
              },
            ),
          ]),
      body: Container(
          child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
        IconButton(
          icon: Icon(Icons.directions_car),
          onPressed: () {
            Navigator.pushNamed(context, '/detect');
          },
          iconSize: 50.0,
        ),
        Text('DETECT!')
      ]))),
    );
  }
}
