import 'package:flutter/material.dart';
import 'package:guess_turn/core/models/player.dart';
import 'package:guess_turn/presentation/widgets/atoms/custom_text.dart';

class PlayerCard extends StatelessWidget {
  final Player player;
  final bool isCurrentPlayer;

  const PlayerCard({
    super.key,
    required this.player,
    required this.isCurrentPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isCurrentPlayer ? Colors.white : Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(12),
        border: isCurrentPlayer 
          ? Border.all(color: Colors.amber, width: 3)
          : null,
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 253, 253, 253), Color.fromARGB(255, 189, 138, 255)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          if (isCurrentPlayer)
            BoxShadow(
              color: Colors.amber.withValues(alpha: 0.5),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: isCurrentPlayer ? Colors.amber[700] : Colors.grey[600],
                size: 20,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: CustomText(
                  text: player.name,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isCurrentPlayer
                  ? Colors.amber[700]! 
                  : Colors.black87,
                  textAlign: TextAlign.center,
                  textOverflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),

          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isCurrentPlayer ? Colors.amber[700] : Colors.grey[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.stars,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${player.wins}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
