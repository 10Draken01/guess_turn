import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/providers/game_provider.dart';
import 'package:guess_turn/presentation/widgets/atoms/confetti_widget.dart';
import 'package:guess_turn/presentation/widgets/atoms/custom_slider.dart';
import 'package:guess_turn/presentation/widgets/atoms/custom_text.dart';
import 'package:guess_turn/presentation/widgets/atoms/fade_message.dart';
import 'package:guess_turn/presentation/widgets/atoms/shimmer_button.dart';
import 'package:guess_turn/presentation/widgets/molecules/number_display_advanced.dart';
import 'package:provider/provider.dart';

class TurnInput extends StatefulWidget {
  const TurnInput({super.key});

  @override
  State<TurnInput> createState() => _TurnInputState();
}

class _TurnInputState extends State<TurnInput> with TickerProviderStateMixin {
  double _selectedNumber = 5.0;
  bool _isProcessing = false;
  late AnimationController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _makeGuess() async {
    if (_isProcessing) return;
    
    setState(() {
      _isProcessing = true;
    });

    final gameProvider = context.read<GameProvider>();
    gameProvider.makeGuess(_selectedNumber.round());

    // Activar confetti si es victoria
    if (gameProvider.lastGuessMessage?.contains('ganado') == true) {
      _confettiController.forward(from: 0.0);
    }

    await Future.delayed(const Duration(milliseconds: 500));
    
    if (mounted) {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return ConfettiWidget(
          showConfetti: gameProvider.lastGuessMessage?.contains('ganado') == true,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.grey[50]!,
                    Colors.grey[100]!,
                  ],
                ),
                border: Border.all(color: Colors.grey[300]!),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const CustomText(
                    text: 'Elige tu número:',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 20),
                  
                  // NumberDisplay con CustomPaint mejorado
                  Hero(
                    tag: 'number-display',
                    child: NumberDisplayAdvanced(
                      number: _selectedNumber.round(),
                    ),
                  ),
                  
                  const SizedBox(height: 25),
                  
                  // CustomSlider existente
                  CustomSlider(
                    value: _selectedNumber,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    onChanged: _isProcessing ? null : (value) {
                      setState(() {
                        _selectedNumber = value;
                      });
                    },
                  ),
                  
                  // Labels existentes
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(text: '0', fontSize: 14, color: Colors.grey),
                        CustomText(text: '5', fontSize: 14, color: Colors.grey),
                        CustomText(text: '10', fontSize: 14, color: Colors.grey),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 25),
                  
                  // Botón con ShaderMask
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: _isProcessing
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ShimmerButton(
                            onPressed: _makeGuess,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lightbulb_outline, size: 24, color: Colors.white),
                                SizedBox(width: 8),
                                CustomText(
                                  text: 'Adivinar',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Mensaje con FadeTransition
                  FadeMessage(
                    message: gameProvider.lastGuessMessage,
                    isWin: gameProvider.lastGuessMessage?.contains('ganado') == true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}