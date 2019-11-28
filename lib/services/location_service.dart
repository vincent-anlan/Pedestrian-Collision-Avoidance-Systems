import 'dart:async';

import 'package:location/location.dart';
import 'package:road_hackers/models/user_location.dart';

class LocationService {
  // Keep track of current Location
  // UserLocation _currentLocation;
  Location location = Location();
  // Continuously emit location updates
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted) {
        location.onLocationChanged().listen((locationData) {
          if (locationData != null) {
            _locationController.add(UserLocation(
              latitude: locationData.latitude,
              longitude: locationData.longitude,
              speed: locationData.speed,
            ));
          }
        });
      }
    });
  }

  StreamController<UserLocation> get locationStream => _locationController;
}
