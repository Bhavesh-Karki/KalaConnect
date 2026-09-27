import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../app/app_colors.dart';

class CraftArtwork extends StatelessWidget {
  const CraftArtwork({super.key, required this.kind});

  final String kind;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$kind illustration',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(painter: _CraftArtworkPainter(kind)),
            Positioned(
              left: 8,
              bottom: 8,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .82),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    'Illustration',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CraftArtworkPainter extends CustomPainter {
  const _CraftArtworkPainter(this.kind);

  final String kind;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = ivory);
    for (var i = 0; i < 5; i++) {
      canvas.drawCircle(
        Offset(size.width * (.15 + i * .18), size.height * .18),
        12 + i * 2,
        Paint()..color = ochre.withValues(alpha: .25),
      );
    }
    switch (kind) {
      case 'basket':
        _drawBasket(canvas, size);
      case 'tray':
        _drawTray(canvas, size);
      case 'textile':
        _drawTextile(canvas, size);
      case 'lamp':
        _drawLamp(canvas, size);
      case 'vase':
        _drawVase(canvas, size);
      default:
        _drawPot(canvas, size);
    }
  }

  void _drawPot(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * .58),
      width: size.width * .48,
      height: size.height * .58,
    );
    canvas.drawOval(rect, Paint()..color = terracotta);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height * .32),
          width: size.width * .36,
          height: size.height * .12,
        ),
        const Radius.circular(30),
      ),
      Paint()..color = teal,
    );
  }

  void _drawVase(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(size.width * .44, size.height * .22)
      ..quadraticBezierTo(
        size.width * .56,
        size.height * .35,
        size.width * .5,
        size.height * .46,
      )
      ..quadraticBezierTo(
        size.width * .75,
        size.height * .62,
        size.width * .58,
        size.height * .86,
      )
      ..lineTo(size.width * .42, size.height * .86)
      ..quadraticBezierTo(
        size.width * .25,
        size.height * .62,
        size.width * .5,
        size.height * .46,
      )
      ..quadraticBezierTo(
        size.width * .44,
        size.height * .35,
        size.width * .56,
        size.height * .22,
      )
      ..close();
    canvas.drawPath(path, Paint()..color = ochre);
  }

  void _drawLamp(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * .58),
      width: size.width * .5,
      height: size.height * .58,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(26)),
      Paint()..color = terracotta,
    );
    for (var row = 0; row < 3; row++) {
      for (var col = 0; col < 3; col++) {
        canvas.drawCircle(
          Offset(
            size.width * (.39 + col * .11),
            size.height * (.43 + row * .12),
          ),
          5,
          Paint()..color = ivory,
        );
      }
    }
    canvas.drawCircle(
      Offset(size.width / 2, size.height * .3),
      18,
      Paint()..color = ochre,
    );
  }

  void _drawBasket(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      size.width * .2,
      size.height * .34,
      size.width * .6,
      size.height * .42,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(18)),
      Paint()..color = ochre.withValues(alpha: .35),
    );
    final weave = Paint()
      ..color = ochre
      ..strokeWidth = 4;
    for (var i = 0; i < 6; i++) {
      final x = rect.left + rect.width * i / 5;
      canvas.drawLine(Offset(x, rect.top), Offset(x - 22, rect.bottom), weave);
    }
    canvas.drawArc(
      Rect.fromLTWH(
        size.width * .28,
        size.height * .18,
        size.width * .44,
        size.height * .34,
      ),
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = teal
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawTray(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * .55),
      width: size.width * .68,
      height: size.height * .42,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(22)),
      Paint()..color = ochre.withValues(alpha: .45),
    );
    final line = Paint()
      ..color = teal
      ..strokeWidth = 4;
    for (var i = 0; i < 6; i++) {
      canvas.drawLine(
        Offset(rect.left + i * rect.width / 5, rect.top),
        Offset(rect.left, rect.top + i * rect.height / 5),
        line,
      );
    }
  }

  void _drawTextile(Canvas canvas, Size size) {
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height * .56),
      width: size.width * .7,
      height: size.height * .52,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(14)),
      Paint()..color = teal,
    );
    final colors = [ochre, ivory, terracotta, Colors.white];
    for (var i = 0; i < 8; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          rect.left + i * rect.width / 8,
          rect.top,
          rect.width / 12,
          rect.height,
        ),
        Paint()..color = colors[i % colors.length].withValues(alpha: .9),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CraftArtworkPainter oldDelegate) =>
      oldDelegate.kind != kind;
}
