import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';
import '../widgets/player_scoreboard.dart';
import '../widgets/turn_input.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'GuessTurn - Configuración'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              final gameProvider = context.read<GameProvider>();
              switch (value) {
                case 'reset':
                  _showResetDialog(context, gameProvider);
                  break;
                case 'new_game':
                  _showNewGameDialog(context, gameProvider);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'reset',
                child: Row(
                  children: [
                    Icon(Icons.refresh, color: Colors.blue),
                    SizedBox(width: 8),
                    CustomText(text: 'Reiniciar Partida'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'new_game',
                child: Row(
                  children: [
                    Icon(Icons.home, color: Colors.green),
                    SizedBox(width: 8),
                    CustomText(text: 'Nueva Configuración'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Consumer<GameProvider>(
        builder: (context, gameProvider, child) {
          if (!gameProvider.isGameStarted) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          return Column(
            children: [
              // Player scoreboard
              const PlayerScoreboard(),
              
              // Game area
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Current turn indicator
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            const CustomText(
                              text: 'Turno de:',
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                            const SizedBox(height: 10),
                            CustomText(
                              text: gameProvider.currentPlayer.name,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Turn input widget
                      const TurnInput(),
                      
                      const SizedBox(height: 30),
                      
                      // Last guess message
                      if (gameProvider.lastGuessMessage != null)
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: gameProvider.lastGuessMessage!.contains('ganado')
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: gameProvider.lastGuessMessage!.contains('ganado')
                                  ? Colors.green
                                  : Colors.orange,
                            ),
                          ),
                          child: CustomText(
                            text: gameProvider.lastGuessMessage!,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: gameProvider.lastGuessMessage!.contains('ganado')
                              ? Colors.green[800]!
                              : Colors.orange[800]!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showResetDialog(BuildContext context, GameProvider gameProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomText(text: 'Reiniciar Partida'),
          content: const CustomText(text: '¿Estás seguro de que quieres reiniciar la partida? Se reiniciarán todas las victorias.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const CustomText(text: 'Cancelar'),
            ),
            TextButton(
              onPressed: () {
                gameProvider.resetGame();
                Navigator.of(context).pop();
              },
              child: const CustomText(text: 'Reiniciar'),
            ),
          ],
        );
      },
    );
  }

  void _showNewGameDialog(BuildContext context, GameProvider gameProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const CustomText(text: 'Nueva Configuración'),
          content: const CustomText(text: '¿Quieres volver a la pantalla de configuración para cambiar jugadores?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const CustomText(text: 'Cancelar'),
            ),
            TextButton(
              onPressed: () {
                gameProvider.restartFromSetup();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const CustomText(text: 'Sí, cambiar'),
            ),
          ],
        );
      },
    );
  }
}