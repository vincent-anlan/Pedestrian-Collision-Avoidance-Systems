import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:road_hackers/models/sharabledata.dart';

class DataNotifier extends ValueNotifier<SharableData> {
  static AudioCache player = AudioCache();

  DataNotifier(SharableData value) : super(value);

  void changeDectionMsg(String msg) {
    value.displayMsg = msg;
    notifyListeners();
  }

  void changeDectionColor(Color color) {
    value.color = color;
    notifyListeners();
    if (color == Colors.red) {
      DateTime now = DateTime.now();
      if (now.millisecondsSinceEpoch - value.last.millisecondsSinceEpoch >
          2000) {
        value.last = now;
        player.clearCache();
        player.play('warningSound.mp3');
      }
    }
  }

  void changeNumObjectsPerFrame(double cacheLimit) {
    value.cacheLimit = cacheLimit;
    notifyListeners();
  }

  void changeModleAccuracy(double modelAccuracy) {
    value.modelAccuracy = modelAccuracy;
    notifyListeners();
  }

  void changeSliderValue(double sliderValue) {
    value.sliderValue = sliderValue;
    notifyListeners();
  }

  double getNumObjectsPerFrame() {
    return value.cacheLimit;
  }

  double getModleAccuracy() {
    return value.modelAccuracy;
  }

  double getSliderValue() {
    return value.sliderValue;
  }

  // void changeControlValue(controller){
  //   value.controller = controller;
  // }
}
