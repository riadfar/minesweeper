import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String concept;
  final String hint;
  final TextEditingController controller;
  final bool? name;
  const MyTextField({
    super.key,
    required this.concept,
    required this.hint,
    required this.controller, this.name,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.deepPurple,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[800],
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        labelText: concept,
        hintText: hint,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        filled: true,
        fillColor: Colors.white.withAlpha(224),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 24,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
        prefixIcon: _getPrefixIcon(concept),
        suffixIcon:
            controller.text.isNotEmpty
                ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[400], size: 20),
                  onPressed: () => controller.clear(),
                )
                : null,
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 12,
          height: 0.8,
        ),
      ),
      keyboardType: name!?TextInputType.name:TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter a $concept";
        }
        final val = int.tryParse(value);
        if (val == null || val <= 0) {
          return "Positive numbers only";
        }
        return null;
      },
    );
  }

  Widget _getPrefixIcon(String concept) {
    switch (concept.toLowerCase()) {
      case 'width':
        return Icon(
          Icons.aspect_ratio_rounded,
          color: Colors.grey[500],
          size: 30,
        );
      case 'height':
        return Icon(Icons.height, color: Colors.grey[500], size: 30);
      case 'number of mines':
        return Icon(Icons.dangerous, color: Colors.grey[500], size: 30);
      case '':
        return Icon(Icons.save,color: Colors.grey[500], size: 30);
      default:
        return Icon(Icons.edit, color: Colors.grey[500], size: 30);
    }
  }
}
