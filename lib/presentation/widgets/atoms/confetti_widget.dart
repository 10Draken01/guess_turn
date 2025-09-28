import 'dart:math';
import 'package:flutter/material.dart';

class ConfettiPainter extends CustomPainter {
  final Animation<double> animation;
  final List<Particle> particles;

  ConfettiPainter(this.animation, this.particles) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    
    for (var particle in particles) {
      paint.color = particle.color.withOpacity(
        (1.0 - animation.value).clamp(0.0, 1.0)
      );
      
      final x = particle.startX + (particle.endX - particle.startX) * animation.value;
      final y = particle.startY + (particle.endY - particle.startY) * animation.value;
      
      canvas.drawCircle(Offset(x, y), particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  final double startX, startY;
  final double endX, endY;
  final Color color;
  final double size;

  Particle({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.color,
    required this.size,
  });
}

class ConfettiWidget extends StatefulWidget {
  final Widget child;
  final bool showConfetti;

  const ConfettiWidget({
    super.key,
    required this.child,
    required this.showConfetti,
  });

  @override
  State<ConfettiWidget> createState() => _ConfettiWidgetState();
}

class _ConfettiWidgetState extends State<ConfettiWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  List<Particle> particles = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _generateParticles();
  }

  void _generateParticles() {
    final random = Random();
    particles = List.generate(50, (index) {
      return Particle(
        startX: 200 + random.nextDouble() * 100,
        startY: 300 + random.nextDouble() * 100,
        endX: random.nextDouble() * 400,
        endY: random.nextDouble() * 800,
        color: [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.purple]
            [random.nextInt(5)],
        size: 3 + random.nextDouble() * 5,
      );
    });
  }

  @override
  void didUpdateWidget(ConfettiWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showConfetti && !oldWidget.showConfetti) {
      _generateParticles();
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.showConfetti)
          Positioned.fill(
            child: CustomPaint(
              painter: ConfettiPainter(_animation, particles),
            ),
          ),
      ],
    );
  }
}