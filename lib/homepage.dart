import 'package:flutter/material.dart';
import 'package:road_hackers/datanotifier.dart';
import 'package:road_hackers/detectpage.dart';
import 'models/sharabledata.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataNotifier notifier = DataNotifier(SharableData());
  String cacheLimit = "";
  bool isCAMSwitched = true;
  double _sliderValue = 0.0;

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
              title: Text('SENSITIVITY'),
              trailing: SizedBox(
                width: 100,
                child: Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 15.0,
                  onChanged: (newRating) {
                    setState(() => _sliderValue = newRating);
                    notifier.changeSliderValue(newRating);
                  },
                  value: _sliderValue,
                ),
              ),
            ),
            ListTile(
                title: Text('CACHE LIMIT (MB)'),
                trailing: SizedBox(
                  width: 100,
                  child: TextField(
                    decoration:
                        new InputDecoration.collapsed(hintText: cacheLimit),
                    keyboardType: TextInputType.number,
                    onChanged: (text) {
                      cacheLimit = text;
                      notifier.changeCacheLimite(text);
                    },
                  ),
                )),
            ListTile(
              title: Text('DASH CAM'),
              trailing: SizedBox(
                width: 100,
                child: Switch(
                  value: isCAMSwitched,
                  onChanged: (value) {
                    setState(() {
                      isCAMSwitched = value;
                      notifier.changeisCAMSwitched(value);
                    });
                  },
                  activeTrackColor: Colors.lightBlueAccent,
                  activeColor: Colors.blue,
                ),
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
        // IconButton(
        //   icon: Icon(Icons.directions_car),
        //   onPressed: () {
        //     Navigator.pushNamed(context, '/detect');
        //   },
        //   iconSize: 50.0,
        // ),
        InkWell(
          child: Ink.image(
            image: AssetImage('assets/radar.png'),
            fit: BoxFit.cover,
            width: 100.0,
            height: 100.0,
          ),
          onTap: (){
            Navigator.pushNamed(context, '/detect');
          }
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('DETECT!'),
        )
      ]))),
    );
  }
}
