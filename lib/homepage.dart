import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              title: Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
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
