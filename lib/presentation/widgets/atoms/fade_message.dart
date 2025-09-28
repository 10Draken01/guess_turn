import 'package:flutter/material.dart';

class FadeMessage extends StatefulWidget {
  final String? message;
  final bool isWin;

  const FadeMessage({
    super.key,
    this.message,
    required this.isWin,
  });

  @override
  State<FadeMessage> createState() => _FadeMessageState();
}

class _FadeMessageState extends State<FadeMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(FadeMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.message != oldWidget.message) {
      if (widget.message != null) {
        _controller.forward(from: 0.0);
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.message == null) {
      return const SizedBox.shrink();
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: widget.isWin
              ? Colors.green.withOpacity(0.1)
              : Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: widget.isWin ? Colors.green : Colors.orange,
          ),
        ),
        child: Text(
          widget.message!,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: widget.isWin ? Colors.green[800] : Colors.orange[800],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}