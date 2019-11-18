import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:road_hackers/sharabledata.dart';

class DetectionNotifier extends ValueNotifier<SharableData> {
  DetectionNotifier(SharableData value) : super(value);

  void changeDectionMsg(String msg) {
    value.displayMsg = msg;
    notifyListeners();
  }

  void changeDectionColor(Color color) {
    value.color = color;
    notifyListeners();
    // if (color == Colors.red) {
    //   AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
    //   audioPlayer.play("http://downsc.chinaz.net/Files/DownLoad/sound1/201411/5185.mp3");
    // }
  }
}
