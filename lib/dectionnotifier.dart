import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:road_hackers/sharabledata.dart';

class DetectionNotifier extends ValueNotifier<SharableData> {
  static AudioCache player = AudioCache();
  
  DetectionNotifier(SharableData value) : super(value);

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
}
