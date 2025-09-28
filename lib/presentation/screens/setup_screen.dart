import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/providers/game_provider.dart';
import 'package:guess_turn/presentation/screens/game_screen.dart';
import 'package:guess_turn/presentation/widgets/atoms/custom_text.dart';
import 'package:guess_turn/presentation/widgets/molecules/hero_button.dart';
import 'package:guess_turn/presentation/widgets/molecules/name_input.dart';
import 'package:guess_turn/presentation/widgets/molecules/player_count_button.dart';
import 'package:provider/provider.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  int _selectedPlayerCount = 2;
  final List<TextEditingController> _nameControllers = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _nameControllers.clear();
    for (int i = 0; i < _selectedPlayerCount; i++) {
      _nameControllers.add(TextEditingController());
    }
  }

  @override
  void dispose() {
    for (var controller in _nameControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _onPlayerCountChanged(int count) {
    setState(() {
      _selectedPlayerCount = count;
      _initializeControllers();
    });
  }

  void _startGame() {
    if (_formKey.currentState!.validate()) {
      final playerNames = _nameControllers.map((controller) => controller.text.trim()).toList();
      
      context.read<GameProvider>().setupPlayers(playerNames);
      
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const GameScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(text: 'GuessTurn - Configuración'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const Hero(
                  tag: 'app-title',
                  child: Material(
                    color: Colors.transparent,
                    child: CustomText(
                      text: '¡Bienvenido a GuessTurn!',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                
                const SizedBox(height: 10),
                
                const CustomText(
                  text: 'Un juego donde debes adivinar un número del 0 al 10. ¡El primero en acertarlo gana!',
                  fontSize: 16,
                ),
                
                const SizedBox(height: 30),
                
                const CustomText(
                  text: '¿Cuántos jugadores van a participar?',
                  fontSize: 18,
                ),
                
                const SizedBox(height: 15),
                
                Row(
                  children: [
                    PlayerCountButton(
                      count: 2,
                      isSelected: _selectedPlayerCount == 2,
                      onTap: _onPlayerCountChanged,
                    ),
                    const SizedBox(width: 20),
                    PlayerCountButton(
                      count: 4,
                      isSelected: _selectedPlayerCount == 4,
                      onTap: _onPlayerCountChanged,
                    ),
                  ],
                ),
                
                const SizedBox(height: 30),
                
                const CustomText(
                  text: 'Nombres de los jugadores:',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                
                const SizedBox(height: 15),

                ...List.generate(_selectedPlayerCount, (index) {
                  return NameInput(
                    controller: _nameControllers[index],
                    labelText: 'Jugador ${index + 1}',
                  );
                }),

                const SizedBox(height: 40),
                
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: HeroButton(
                    heroTag: 'start-game-button',
                    onPressed: _startGame,
                    child: const CustomText(
                      text: 'Iniciar Partida',
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}