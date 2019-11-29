import 'dart:async';

import 'package:sensors/sensors.dart';

class AccService {
  // Keep track of current Location
  // UserLocation _currentLocation;

  // Continuously emit location updates
  StreamController<double> _accController =
      StreamController<double>.broadcast();

  AccService() {
    userAccelerometerEvents.listen((acc) {
      if (acc != null && !_accController.isClosed) {
        _accController.add(acc.z);
      }
    });
  }

  StreamController<double> get accStream => _accController;
}
