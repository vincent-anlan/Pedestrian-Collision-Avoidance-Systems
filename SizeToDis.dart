
import 'dart:math';
//double size = 1.7;
double ang = 0.353717*pi;//0.364*pi;


class SizeToDis {

  List STD(size,
      ratioH,ratioW,resH, resW,ang,coordX,label){

    if (label==1) {//The object is a person
      if (size==-1) size = 1.66;
      double w= size/(ratioH*(ratioW/ratioH));
      double baseline = w / 2;
      double normal = baseline / tan(ang / 2);
      double a = ((0.5 - coordX - ratioW / 2) * w).abs();
      double distance = sqrt(pow(a, 2)
                + pow(normal, 2));

      /*double w = size / ratioH;
      double wx = w * (resW / resH);
      double baseline = w / 2;
      double normal = baseline / tan(ang / 2);
      double a = ((0.5 - coordX - ratioW / 2) * wx).abs();

      double distance = sqrt(pow(a, 2)
          + pow(normal, 2));*/


      double ang2=atan((a/normal));

      var res=[distance,ang2];//ang2 is in n*pi
      return res;

    }else if(label==2){//The object is a car
      if (size==-1) size = 2.0;
      double w=size/ratioW;

      //double w =size/(ratioW*(resW/resH));
      double baseline = w / 2;
      double normal = baseline / tan(ang / 2);
      double distance = normal;

      var res=[distance,0];
      return res;

    }else{// The object is a bike
      return [10000,-2];

    }



  }
}




