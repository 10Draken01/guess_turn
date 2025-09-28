
import 'package:flutter/material.dart';
import 'package:guess_turn/presentation/widgets/atoms/custom_text.dart';

class PlayerCountButton extends StatelessWidget {
  final int count;
  final bool isSelected;
  final ValueChanged<int> onTap;
  const PlayerCountButton({
    super.key,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(count),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: isSelected
                  ? LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.8),
                      ],
                    )
                  : LinearGradient(
                      colors: [Colors.grey[200]!, Colors.grey[300]!],
                    ),
              border: Border.all(
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey[400]!,
              ),
            ),
            child: Center(
              child: CustomText(
                text: '$count Jugadores',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}