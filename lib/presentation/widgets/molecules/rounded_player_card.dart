import 'package:flutter/material.dart';

class RoundedPlayerCard extends StatelessWidget {
  final Widget child;
  final bool isCurrentPlayer;

  const RoundedPlayerCard({
    super.key,
    required this.child,
    required this.isCurrentPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isCurrentPlayer
                ? [Colors.amber[300]!, Colors.amber[600]!]
                : [Colors.grey[200]!, Colors.grey[400]!],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}