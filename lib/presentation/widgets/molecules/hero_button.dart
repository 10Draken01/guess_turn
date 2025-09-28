import 'package:flutter/material.dart';

class HeroButton extends StatelessWidget {
  final String heroTag;
  final Widget child;
  final VoidCallback? onPressed;

  const HeroButton({
    super.key,
    required this.heroTag,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[400]!, Colors.blue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}