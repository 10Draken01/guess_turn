import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/screens/game_screen.dart';
import 'package:guess_turn/presentation/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

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
        MaterialPageRoute(builder: (context) => const GameScreen()),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomText(
                text: '¡Bienvenido a GuessTurn!', 
                fontSize: 24, 
                fontWeight: FontWeight.bold
              ),

              const SizedBox(height: 10),

              const CustomText(
                text: 'Un juego donde debes adivinar un número del 0 al 10. ¡El primero en acertarlo gana!', 
                fontSize: 16
              ),

              const SizedBox(height: 30),
              
              const CustomText(
                text: '¿Cuántos jugadores van a participar?', 
                fontSize: 18
              ),

              const SizedBox(height: 15),
              
              Row(
                children: [
                  _buildPlayerCountButton(2),
                  const SizedBox(width: 20),
                  _buildPlayerCountButton(4),
                ],
              ),
              
              const SizedBox(height: 30),
              
              const CustomText(
                text: 'Nombres de los jugadores:', 
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),

              const SizedBox(height: 15),
              
              ..._buildNameInputs(),
              
              const SizedBox(height: 40),
              
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const CustomText(
                    text: 'Iniciar Partida', 
                    fontSize: 18
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerCountButton(int count) {
    final isSelected = _selectedPlayerCount == count;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onPlayerCountChanged(count),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey[400]!,
            ),
          ),
          child: Center(
            child: CustomText(
              text: '$count Jugadores',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black87
            )
          ),
        ),
      ),
    );
  }

  List<Widget> _buildNameInputs() {
    return List.generate(_selectedPlayerCount, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: TextFormField(
          controller: _nameControllers[index],
          decoration: InputDecoration(
            labelText: 'Jugador ${index + 1}',
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.person),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Por favor ingresa un nombre';
            }
            if (value.trim().length < 2) {
              return 'El nombre debe tener al menos 2 caracteres';
            }
            return null;
          },
        ),
      );
    });
  }
}