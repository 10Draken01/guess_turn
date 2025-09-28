import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/widgets/atoms/custom_text.dart';

class NumberDisplayAdvanced extends StatelessWidget {
  final int number;
  final double width;
  final double height;

  const NumberDisplayAdvanced({
    super.key,
    required this.number,
    this.width = 80,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: NumberCirclePainter(
          number: number,
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: CustomText(
            text: '$number',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class NumberCirclePainter extends CustomPainter {
  final int number;
  final Color color;

  NumberCirclePainter({required this.number, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          color,
          color.withOpacity(0.7),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Círculo principal
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2,
      paint,
    );

    // Sombra interna
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 3);

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2 - 2,
      shadowPaint,
    );

    // Brillo superior
    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2 - 5),
      size.width / 4,
      highlightPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}