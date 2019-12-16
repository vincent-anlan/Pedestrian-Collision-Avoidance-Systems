import 'package:flutter/material.dart';
import 'package:road_hackers/services/datanotifier.dart';

class HomePage extends StatefulWidget {
  HomePage(this.notifier);
  DataNotifier notifier;
  _HomePageState createState() => _HomePageState(notifier);
}

class _HomePageState extends State<HomePage> {
  DataNotifier notifier;
  double _numObjectsPerFrame = 6.0;
  bool isModelswitched = true;
  double _sliderValue = 1.0;
  double _modelAccuracy = 1.0;

  _HomePageState(this.notifier);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: 400,
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: 80,
                child: DrawerHeader(
                  child: Center(
                      child: Text('Setting',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white))),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
              ),
              ListTile(
                leading: Text('SENSITIVITY'),
                subtitle:
                    Center(child: Text('${0.45 + (_sliderValue - 1) * 0.05}')),
                title: SizedBox(
                  width: 150,
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
                leading: Text('OBJECTS PER FRAME'),
                subtitle: Center(child: Text('${_numObjectsPerFrame.round()}')),
                title: SizedBox(
                  width: 150,
                  child: Slider(
                    activeColor: Colors.indigoAccent,
                    min: 5.0,
                    max: 10.0,
                    divisions: 5,
                    onChanged: (newRating) {
                      setState(() => _numObjectsPerFrame = newRating);
                      notifier.changeNumObjectsPerFrame(newRating);
                    },
                    value: _numObjectsPerFrame,
                  ),
                ),
              ),
              ListTile(
                leading: Text('MODEL ACCURACY'),
                subtitle: Center(
                    child: Text(
                        '${_modelAccuracy == 0.0 ? "high speed" : "high performance"}')),
                title: SizedBox(
                  width: 150,
                  child: Slider(
                    activeColor: Colors.indigoAccent,
                    min: 0.0,
                    max: 1.0,
                    divisions: 1,
                    onChanged: (newRating) {
                      setState(() => _modelAccuracy = newRating);
                      notifier.changeModleAccuracy(newRating);
                    },
                    value: _modelAccuracy,
                  ),
                ),
              ),
            ],
          ),
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
              onPressed: () => Navigator.pushNamed(context, '/gallery'),
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
