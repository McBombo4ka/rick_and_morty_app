import 'package:flutter/material.dart';

class ThreeColumnsIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const ThreeColumnsIcon({super.key, this.size = 24, this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _ThreeColumnsPainter(color ?? Theme.of(context).iconTheme.color!),
    );
  }
}

class _ThreeColumnsPainter extends CustomPainter {
  final Color color;

  _ThreeColumnsPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final gap = size.width * 0.1;
    final colWidth = (size.width - gap * 2) / 3;

    for (int i = 0; i < 3; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH((colWidth + gap) * i, 0, colWidth, size.height),
          const Radius.circular(2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
