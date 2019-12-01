import 'package:flutter/material.dart';
import 'models/sharabledata.dart';
import 'services/datanotifier.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataNotifier notifier = DataNotifier(SharableData());
  double _numObjectsPerFrame = 6.0;
  bool isModelswitched = true;
  double _sliderValue = 1.0;
  double _modelAccrucy = 1.0;

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
                  max: 2.0,
                  divisions: 2,
                  onChanged: (newRating) {
                    setState(() => _sliderValue = newRating);
                    notifier.changeSliderValue(newRating);
                  },
                  value: _sliderValue,
                ),
              ),
            ),
            ListTile(
              title: Text('OBJECTS PER FRAME'),
              trailing: SizedBox(
                width: 100,
                child: Slider(
                  activeColor: Colors.indigoAccent,
                  min: 5.0,
                  max: 10.0,
                  divisions: 6,
                  onChanged: (newRating) {
                    setState(() => _numObjectsPerFrame = newRating);
                    notifier.changeNumObjectsPerFrame(newRating);
                  },
                  value: _numObjectsPerFrame,
                ),
              ),
            ),
            ListTile(
              title: Text('MODEL ACCURACY'),
              trailing: SizedBox(
                width: 100,
                child: Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 1.0,
                  divisions: 1,
                  onChanged: (newRating) {
                    setState(() => _modelAccrucy = newRating);
                    notifier.changeModleAccuracy(newRating);
                  },
                  value: _modelAccrucy,
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
                Navigator.pushNamed(context, '/gallery');
              },
            ),
          ]),
      body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage("assets/background.jpg"),
          //     fit: BoxFit.fill,
          //   ),
          // ),
          child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
        InkWell(
            child: Ink.image(
              image: AssetImage('assets/radar.png'),
              fit: BoxFit.cover,
              width: 100.0,
              height: 100.0,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/detect');
            }),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('DETECT!', style: TextStyle(fontWeight: FontWeight.bold)),
        )
      ]))),
    );
  }
}
