import 'dart:math';

// use this class instead, distance will be calculated in constructor
enum ObjectType { pedestrian, car, tram, truck, cyclist, van }

class DetectedObject {
  ObjectType type;
  double x = -1, y = -1, width = -1, height = -1;
  double distance = -1;
  double relativeSpeed = -1;
  final double angle = 0.353717 * pi; //0.364*pi;
  final int resH = 2436;
  final int resW = 1125;

  DetectedObject(type, x, y, width, height) {
    Map typeMap = {
      "pedestrian": ObjectType.pedestrian,
      "car": ObjectType.car,
      "tram": ObjectType.tram,
      "truck": ObjectType.truck,
      "cyclist": ObjectType.cyclist,
      "van": ObjectType.van
    };
    this.type = typeMap[type];
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    int size = -1;
    this.distance = getDistance(size)[0];
  }
  // return [distance, angle]
  List getDistance(size) {
    if (type == ObjectType.pedestrian) {
      //The object is a person
      if (size == -1) size = 1.66;
      double w = size / (this.height * (this.resW / this.resH));
      double baseline = w / 2;
      double normal = baseline / tan(this.angle / 2);
      double a = ((0.5 - this.x - this.width / 2) * w).abs();
      double distance = sqrt(pow(a, 2) + pow(normal, 2));

      double ang2 = atan((a / normal));
      var res = [distance, ang2]; //ang2 is in n*pi
      return res;
    } else if (this.type == ObjectType.car || this.type == ObjectType.cyclist) {
      //The object is a car
      if (size == -1) size = 2.0;
      double w = size / this.width;
      //double w =size/(ratioW*(resW/resH));

      double baseline = w / 2;
      double normal = baseline / tan(this.angle / 2);
      double distance = normal;
      var res = [distance, 0];

      return res;
    } else if (this.type == ObjectType.truck) {
      //The object is a car
      if (size == -1) size = 2.5;
      double w = size / this.width;
      double baseline = w / 2;
      double normal = baseline / tan(this.angle / 2);
      double distance = normal;
      var res = [distance, 0];

      return res;
    } else {
      // The object is a bike
      return [10000, -2];
    }
  }

  bool isFrontVehicle() {
    double xThreshold = 0.1;
    //double yThreshold = 0.2;
    // return true;

    return (this.x + 0.5 * this.width - 0.5).abs() <= xThreshold &&
        // (this.y + 0.5 * this.height - 0.5).abs() <= yThreshold &&
        (this.type == ObjectType.car ||
            this.type == ObjectType.truck ||
            this.type == ObjectType.van);
  }

  bool isFrontPedestrian() {
    double xThreshold = 0.3;
    //double yThreshold = 0.2;
    // return true;
    print((this.x + 0.5 * this.width - 0.5).abs());
    return (this.x + 0.5 * this.width - 0.5).abs() <= xThreshold &&
        // (this.y + 0.5 * this.height - 0.5).abs() <= yThreshold &&
        this.type == ObjectType.pedestrian;
  }
}
