import 'dart:math';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

import 'distance.dart';

enum WarnColor { red, green, yellow }

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
  double distance =
      (speed * speed / (250 * friction)) + recogTime * (speed / 3.6);
  print("Braking Distance: " + distance.toString());
  return distance;
}

WarnColor getVehicleColor(double speed, double realDistance) {
  var safeDistance = getBrakingDistance(speed, 0.7, 0.4);
  if (realDistance < (safeDistance * 2 / 3)) {
    return WarnColor.red;
  } else if (realDistance < safeDistance) {
    return WarnColor.yellow;
  } else {
    return WarnColor.green;
  }
}

WarnColor getPedestrianColor(double speed,double acceleration ,double realDistance) {
  var safeDistance;
   if (acceleration < 0)
     safeDistance = pow(speed, 2) / ((0 - acceleration) * 2);
   else
     safeDistance = (speed/3.6)/2;

  if (realDistance < safeDistance*(2/3)) {
    return WarnColor.red;
  }else if(realDistance < safeDistance){
   return WarnColor.yellow;
  }else {
    return WarnColor.green;
  }
}

getBndboxColor(double speed,double acc ,List<DetectedObject> objs) {
  print("enter color selection");
  List<DetectedObject> temp = new List<DetectedObject>();
  for (var o in objs) {
    if (o.isFrontVehicle()) {
      temp.add(o);
      print("add car to list");
    }
    if (o.type == ObjectType.pedestrian) {
      temp.add(o);
      print("add ppl to list");
    }
  }
  int wc = 0;
  Map colorMap = {WarnColor.red: 2, WarnColor.yellow: 1, WarnColor.green: 0};
  for (var i in temp) {
    if (i.type == ObjectType.pedestrian) {
      wc = max(colorMap[getPedestrianColor(speed,acc ,i.distance)], wc);
    } else {
      wc = max(colorMap[getVehicleColor(speed, i.distance)], wc);
    }
    print('wc:' + wc.toString());
  }
  if (wc == 0) {
    return Colors.green;
  } else if (wc == 1) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}
