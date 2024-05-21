import 'package:flutter/material.dart';

class CustomProgressIndicator extends CustomPainter {
  final double progress;
  final Color color;

  CustomProgressIndicator({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    Paint progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withOpacity(0.5), color],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2))
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double angle = 2 * 3.141592653589793 * (progress / 100);
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, backgroundPaint);
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.height), -3.141592653589793 / 2, -angle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
