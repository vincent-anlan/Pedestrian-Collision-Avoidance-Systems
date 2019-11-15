
import 'package:flutter/material.dart';

class DetectionNotifier extends ValueNotifier<String>{
  DetectionNotifier(String value) : super(value);

  void changeDectionMsg(String msg){
    value = msg;
    notifyListeners();
  }
}