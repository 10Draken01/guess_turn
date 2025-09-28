import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/widgets/molecules/rounded_player_card.dart';

class PlayersGrid extends StatelessWidget {
  final List<dynamic> players; // Usa dynamic para evitar import issues
  final dynamic currentPlayer;

  const PlayersGrid({
    super.key,
    required this.players,
    required this.currentPlayer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
        ),
        itemCount: players.length,
        itemBuilder: (context, index) {
          final player = players[index];
          final isCurrentPlayer = player == currentPlayer;
          
          return Hero(
            tag: 'player-card-${player.name}',
            child: RoundedPlayerCard(
              isCurrentPlayer: isCurrentPlayer,
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      color: isCurrentPlayer ? Colors.amber[700] : Colors.grey[600],
                      size: 24,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      player.name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isCurrentPlayer ? Colors.amber[700] : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isCurrentPlayer ? Colors.amber[700] : Colors.grey[700],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.stars,
                            color: Colors.white,
                            size: 12,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${player.wins}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}