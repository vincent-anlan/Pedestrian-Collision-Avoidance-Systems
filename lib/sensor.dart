import 'dart:math';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

Future<double> getSpeed() async{
  LocationData currentLocation;
  String error;
  var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
  try {
    currentLocation = await location.getLocation();
  } on PlatformException catch (e) {
    if (e.code == 'PERMISSION_DENIED') {
      var error = 'Permission denied';
      print(error);
    }
    currentLocation = null;
  }
  return currentLocation.speed;
}
