import 'package:flutter/material.dart';

class NameInput extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;

  const NameInput({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.lerp(
                BorderSide(color: Colors.grey[400]!, width: 1),
                BorderSide(color: Theme.of(context).primaryColor, width: 2),
                0.5,
              ),
            ),
            prefixIcon: const Icon(Icons.person),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.8),
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
      ),
    );
  }
}
