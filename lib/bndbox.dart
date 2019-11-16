import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:road_hackers/dectionnotifier.dart';
import 'package:road_hackers/sensor.dart';
import 'dart:math' as math;
import 'models.dart';
import 'package:flutter/foundation.dart';
import 'distance.dart';

class BndBox extends StatelessWidget {
  final List<dynamic> results;
  int previewH;
  int previewW;
  final double screenH;
  final double screenW;
  final String model;
  final DetectionNotifier _text;

  BndBox(this.results, this.previewH, this.previewW, this.screenH, this.screenW,
      this.model, this._text);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      List<DetectedObject> objlist = [];
      try {
        if (results.length != 0) {
          for (var re in results) {
            var _x = re["rect"]["x"];
            var _w = re["rect"]["w"];
            var _y = re["rect"]["y"];
            var _h = re["rect"]["h"];
            var label = re["detectedClass"];
            var confidence = re["confidenceInClass"];
            var obj = new DetectedObject(label, _x, _w, _y, _h);
            var distance = obj.distance;
            String msg = '$label detected!' + ' Distance: $distance';
            _text.changeDectionMsg(msg);
            // _text.changeDectionColor(Colors.red);
            debugPrint('$label detected!!!');
            debugPrint(
                'x: $_x, y: $_y, w: $_w, h: $_h, confidence: $confidence');
            // debugPrint('now: $now.second.round()');
            debugPrint('distance: $distance');
            // debugPrint(new DateFormat("H:m:s").format(now));
            objlist.add(obj);
          }
        }
      } catch (Exception) {
        print("Exception rasied in for loop");
      }
      double speed = 0.0;
      var location = new Location();
      location.onLocationChanged().listen((LocationData currentLocation) {
        speed = currentLocation.speed;
        // print('color:' +
        //     getBndboxColor(currentLocation.speed * 3.6, objlist).toString());
      });
      // speed = 10.0;
      _text.changeDectionColor(getBndboxColor(speed * 3.6, objlist));

      return results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var scaleW, scaleH, x, y, w, h;
        if (screenH / screenW > previewH / previewW) {
          scaleW = screenH / previewH * previewW;
          scaleH = screenH;
          var difW = (scaleW - screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = screenW / previewW * previewH;
          scaleW = screenW;
          var difH = (scaleH - screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }

        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: Container(
            padding: EdgeInsets.only(top: 5.0, left: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromRGBO(37, 213, 253, 1.0),
                width: 3.0,
              ),
            ),
            child: Text(
              "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                color: Color.fromRGBO(37, 213, 253, 1.0),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderStrings() {
      double offset = -10;
      return results.map((re) {
        offset = offset + 14;
        return Positioned(
          left: 10,
          top: offset,
          width: screenW,
          height: screenH,
          child: Text(
            "${re["label"]} ${(re["confidence"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              color: Color.fromRGBO(37, 213, 253, 1.0),
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList();
    }

    List<Widget> _renderKeypoints() {
      var lists = <Widget>[];
      results.forEach((re) {
        var list = re["keypoints"].values.map<Widget>((k) {
          var _x = k["x"];
          var _y = k["y"];
          var scaleW, scaleH, x, y;

          if (screenH / screenW > previewH / previewW) {
            scaleW = screenH / previewH * previewW;
            scaleH = screenH;
            var difW = (scaleW - screenW) / scaleW;
            x = (_x - difW / 2) * scaleW;
            y = _y * scaleH;
          } else {
            scaleH = screenW / previewW * previewH;
            scaleW = screenW;
            var difH = (scaleH - screenH) / scaleH;
            x = _x * scaleW;
            y = (_y - difH / 2) * scaleH;
          }
          return Positioned(
            left: x - 6,
            top: y - 6,
            width: 100,
            height: 12,
            child: Container(
              child: Text(
                "● ${k["part"]}",
                style: TextStyle(
                  color: Color.fromRGBO(37, 213, 253, 1.0),
                  fontSize: 12.0,
                ),
              ),
            ),
          );
        }).toList();

        lists..addAll(list);
      });

      return lists;
    }

    return Stack(
      children: model == mobilenet
          ? _renderStrings()
          : model == posenet ? _renderKeypoints() : _renderBoxes(),
    );
  }
}
