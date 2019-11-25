import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:road_hackers/sharabledata.dart';

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
      player.clearCache();
      player.play('warningSound.mp3');
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
}
