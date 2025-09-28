import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double>? onChanged;

  final double min;
  final double max;
  final int divisions;
  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0,
    this.max = 10,
    this.divisions = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Theme.of(context).primaryColor,
        inactiveTrackColor: Colors.grey[300],
        thumbColor: Theme.of(context).primaryColor,
        overlayColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 15),
        trackHeight: 8,
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        divisions: divisions,
        onChanged: onChanged,
      ),
    );
  }
}
