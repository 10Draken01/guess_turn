import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/widgets/atoms/custom_text.dart';

class VictoryOverlay extends StatelessWidget {
  final String winnerName;
  final int secretNumber;
  final VoidCallback onContinue;

  const VictoryOverlay({
    super.key,
    required this.winnerName,
    required this.secretNumber,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        // IMPORTANTE: Dar tamaño específico al contenedor
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            // Fondo semitransparente que ocupa toda la pantalla
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.7),
            ),
            
            // Contenido centrado con restricciones específicas
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8, // 80% del ancho
                constraints: const BoxConstraints(
                  maxWidth: 400,
                  maxHeight: 300,
                ),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      size: 60,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 20),
                    CustomText(
                      text: '¡$winnerName ha ganado!',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: 'El número era $secretNumber',
                      fontSize: 18,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: onContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      ),
                      child: const CustomText(
                        text: 'Continuar',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}