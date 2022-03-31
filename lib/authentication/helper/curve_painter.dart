
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width,size.height*1.170368);
    path_0.cubicTo(size.width,size.height*1.211063,size.width*0.9912944,size.height*1.244053,size.width*0.9805556,size.height*1.244053);
    path_0.lineTo(size.width*0.01944444,size.height*1.244053);
    path_0.cubicTo(size.width*0.008705556,size.height*1.244053,0,size.height*1.211063,0,size.height*1.170368);
    path_0.lineTo(0,size.height*0.1916705);
    path_0.cubicTo(0,size.height*0.1736842,size.width*0.005184500,size.height*0.1625958,size.width*0.009247917,size.height*0.1718916);
    path_0.lineTo(size.width*0.07988806,size.height*0.3335011);
    path_0.cubicTo(size.width*0.1323475,size.height*0.4535168,size.width*0.1994719,size.height*0.4266189,size.width*0.2441469,size.height*0.2676779);
    path_0.lineTo(size.width*0.2619572,size.height*0.2043137);
    path_0.cubicTo(size.width*0.3122944,size.height*0.02522895,size.width*0.3836833,size.height*-0.04104432,size.width*0.4501639,size.height*0.02959211);
    path_0.lineTo(size.width*0.6673250,size.height*0.2603284);
    path_0.cubicTo(size.width*0.7774111,size.height*0.3772947,size.width*0.8949444,size.height*0.3394874,size.width*0.9982500,size.height*0.1538779);
    path_0.cubicTo(size.width*0.9990639,size.height*0.1524179,size.width,size.height*0.1546642,size.width,size.height*0.1580716);
    path_0.lineTo(size.width,size.height*1.170368);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.color =const  Color(0xff15151E).withOpacity(1.0);
    canvas.drawPath(path_0,paint_0_fill);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}