
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
  }
}