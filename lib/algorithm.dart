import 'package:flutter/material.dart';

Color ccolor = Colors.green;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Predicted time Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
        backgroundColor: Colors.white,
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  double v = 0;
  double a = 0;
  double distance = 0;
  double t = 0;
  TextEditingController _cv ;
  TextEditingController _ca ;
  TextEditingController _cd ;

  @override
  void initState() {
    _cv = new TextEditingController();
    _ca = new TextEditingController();
    _cd = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _cv,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some v';
              }
              v = double.parse(value);
              return null;
            },

          ),
          TextFormField(
            controller: _ca,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some a';
              }
              a = double.parse(value);

              return null;
            },
          ),
          TextFormField(
            controller: _cd,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some d';
              }
              distance = double.parse(value);
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  v = double.parse(_cv.text);
                  a = double.parse(_ca.text);
                  distance = double.parse(_cd.text);
                  t = distance / v + a / 13;
                  if(t<3){
                    ccolor = Colors.red;
                  }else if(t < 4){
                    ccolor = Colors.yellow;
                  }else{
                    ccolor = Colors.green;
                  }
                });


              },
              child: Text('Update'),
            ),
          ),
          Text("v : $v"),
          Text("a : $a"),
          Text("d : $distance"),
          Text("t : $t"),
          Container(
            height: 24,
            color: ccolor,
          ),
        ],
      ),
    );
  }
}