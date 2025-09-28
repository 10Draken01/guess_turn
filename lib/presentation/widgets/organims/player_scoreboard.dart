import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/widgets/atoms/custom_text.dart';
import 'package:guess_turn/presentation/widgets/organims/players_grid.dart';
import 'package:guess_turn/presentation/widgets/organims/victory_overlay.dart';
import 'package:provider/provider.dart';
import '../../providers/game_provider.dart';

class PlayerScoreboard extends StatelessWidget {
  const PlayerScoreboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return Stack(
          children: [
            // Fondo principal con gradiente
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
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
                  
                  // Usar GridView para layout avanzado
                  PlayersGrid(
                    players: gameProvider.players,
                    currentPlayer: gameProvider.currentPlayer,
                  ),
                ],
              ),
            ),
            
            // Overlay de victoria con Stack
            if (gameProvider.lastGuessMessage?.contains('ganado') == true)
              VictoryOverlay(
                winnerName: gameProvider.currentPlayer.name,
                secretNumber: gameProvider.secretNumber ?? 0,
                onContinue: () {
                  // La lógica ya está en GameProvider
                },
              ),
          ],
        );
      },
    );
  }
}