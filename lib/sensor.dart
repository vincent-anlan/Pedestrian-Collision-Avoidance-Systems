import 'dart:math';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

enum Color { red, green, yellow }

Future<LocationData> gps() async {
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
  // return currentLocation.speed;
  return currentLocation;
}

// speed: km/h
double getBrakingDistance(double speed, double friction, double recogTime) {
  double distance = speed * speed * 250 * friction + recogTime * (speed / 3.6);
}

Color getVehicleColor(double speed, double realDistance) {
  var safeDistance = getBrakingDistance(speed, 0.7, 0.4);
  if (realDistance < (safeDistance * 2 / 3)) {
    return Color.red;
  } else if (realDistance < safeDistance) {
    return Color.yellow;
  } else {
    return Color.green;
  }
}

Color getPedestrianColor(
    double speed, double realDistance, double acceleration) {
  var safeDistance;
  //= getBrakingDistance(speed, 0.7, 0.4);
  if (acceleration <= 0)
    safeDistance = pow(speed, 2) / ((0 - acceleration) * 2);
  else
    safeDistance = 10;

  if (realDistance < safeDistance) {
    return Color.yellow;
  } else {
    return Color.green;
  }
}
