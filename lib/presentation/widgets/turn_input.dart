import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/game_provider.dart';

class TurnInput extends StatefulWidget {
  const TurnInput({super.key});

  @override
  State<TurnInput> createState() => _TurnInputState();
}

class _TurnInputState extends State<TurnInput> {
  double _selectedNumber = 5.0;
  bool _isProcessing = false;

  void _makeGuess() async {
    if (_isProcessing) return;
    
    setState(() {
      _isProcessing = true;
    });

    final gameProvider = context.read<GameProvider>();
    gameProvider.makeGuess(_selectedNumber.round());

    // Small delay for better UX
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (mounted) {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
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
          const Text(
            'Elige tu número:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          
          // Number display
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Center(
              child: Text(
                '${_selectedNumber.round()}',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 25),
          
          // Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Theme.of(context).primaryColor,
              inactiveTrackColor: Colors.grey[300],
              thumbColor: Theme.of(context).primaryColor,
              overlayColor: Theme.of(context).primaryColor.withOpacity(0.2),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
              trackHeight: 8,
            ),
            child: Slider(
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
          ),
          
          // Number labels
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0', style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text('5', style: TextStyle(fontSize: 14, color: Colors.grey)),
                Text('10', style: TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
          ),
          
          const SizedBox(height: 25),
          
          // Guess button
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: _isProcessing ? null : _makeGuess,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: _isProcessing ? 0 : 5,
              ),
              child: _isProcessing
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lightbulb_outline, size: 24),
                      SizedBox(width: 8),
                      Text(
                        'Adivinar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        ],
      ),
    );
  }
}