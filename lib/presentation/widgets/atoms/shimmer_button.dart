import 'package:flutter/material.dart';

class ShimmerButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const ShimmerButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  @override
  State<ShimmerButton> createState() => _ShimmerButtonState();
}

class _ShimmerButtonState extends State<ShimmerButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: -2.0, end: 2.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: const [
                Colors.transparent,
                Color.fromARGB(97, 255, 255, 255),
                Colors.transparent,
              ],
              stops: [
                _animation.value - 0.3,
                _animation.value,
                _animation.value + 0.3,
              ].map((stop) => stop.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          blendMode: BlendMode.srcATop,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              // aplicar colores por default
              backgroundColor: Theme.of(context).primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
            onPressed: widget.onPressed,
            child: widget.child,
          ),
        );
      },
    );
  }
}