import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class PlayerScoreboard extends StatelessWidget {
  const PlayerScoreboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              const CustomText(
                text: 'Marcador',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              const SizedBox(height: 15),
              if (gameProvider.players.length <= 2)
                Row(
                  children: gameProvider.players.map((player) => 
                    Expanded(child: _buildPlayerCard(player, gameProvider.currentPlayer == player))
                  ).toList(),
                )
              else
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: gameProvider.players.map((player) => 
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      child: _buildPlayerCard(player, gameProvider.currentPlayer == player),
                    )
                  ).toList(),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlayerCard(player, bool isCurrentPlayer) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isCurrentPlayer ? Colors.white : Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        border: isCurrentPlayer 
          ? Border.all(color: Colors.amber, width: 3)
          : null,
        boxShadow: [
          if (isCurrentPlayer)
            BoxShadow(
              color: Colors.amber.withOpacity(0.5),
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