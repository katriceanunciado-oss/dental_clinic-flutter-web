import 'package:flutter/material.dart';
class AppTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  const AppTextField({super.key, required this.label, this.obscureText = false});
  @override
  Widget build(BuildContext context) => TextFormField(
    obscureText: obscureText,
    autocorrect: !obscureText,
    enableSuggestions: !obscureText,
    decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
    validator: (value) => value == null || value.trim().isEmpty ? 'Please enter $label' : null,
  );
}
