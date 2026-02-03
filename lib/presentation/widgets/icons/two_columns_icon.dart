import 'package:flutter/material.dart';

class TwoColumnsIcon extends StatelessWidget {
  final double size;
  final Color? color;

  const TwoColumnsIcon({super.key, this.size = 24, this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _TwoColumnsPainter(color ?? Theme.of(context).iconTheme.color!),
    );
  }
}

class _TwoColumnsPainter extends CustomPainter {
  final Color color;

  _TwoColumnsPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final gap = size.width * 0.15;
    final colWidth = (size.width - gap) / 2;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, colWidth, size.height),
        const Radius.circular(2),
      ),
      paint,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(colWidth + gap, 0, colWidth, size.height),
        const Radius.circular(2),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
