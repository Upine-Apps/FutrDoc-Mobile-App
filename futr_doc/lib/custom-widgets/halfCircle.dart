import 'package:flutter/material.dart';
import 'package:futr_doc/theme/appColor.dart';

class MyArc extends StatelessWidget {
  final double width;
  final double height;

  const MyArc({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(context: context),
      size: Size(width, height),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  final BuildContext context;

  const MyPainter({required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Theme.of(context).secondaryHeaderColor;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, -1),
        height: size.height,
        width: size.width + 100,
      ),
      0,
      3.14,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
