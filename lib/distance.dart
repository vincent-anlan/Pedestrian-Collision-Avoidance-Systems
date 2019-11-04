import 'dart:math';

double STD(ratioH, ratioW, coordX) {
  double size = 1.7;
  double ang = 0.364 * pi;
  var resH = 2436;
  var resW = 1125;
  //double w= size/(ratioH*(ratioW/ratioH));
  double w = size / ratioH;

  double wx = w * (resW / resH);

  double baseline = w / 2;

  double normal = baseline / tan(ang / 2);
  // print(normal);
  double a = ((0.5 - coordX - ratioW / 2) * wx).abs();
  // print(a);

  double distance = sqrt(pow(a, 2) + pow(normal, 2));
  return distance;
}
