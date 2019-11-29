import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'models/sharabledata.dart';

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
      if(now.millisecondsSinceEpoch - value.last.millisecondsSinceEpoch > 2000){
        value.last = now;
        player.clearCache();
        player.play('warningSound.mp3');
      }
    }
  }

  void changeCacheLimite(String cacheLimit) {
    value.cacheLimit = cacheLimit;
    notifyListeners();
  }

  void changeisCAMSwitched(bool isCAMSwitched) {
    value.isCAMSwitched = isCAMSwitched;
    notifyListeners();
  }

  void changeSliderValue(double sliderValue) {
    value.sliderValue = sliderValue;
    notifyListeners();
  }

  // void changeControlValue(controller){
  //   value.controller = controller;
  // }
}
