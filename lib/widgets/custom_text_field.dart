import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextInputType inputType;
  final Function(String)?  onChanged;

  const CustomTextField({
    super.key,
    required this.hint,
    required this.inputType,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      
      style: const TextStyle(
    
      ),
      onChanged: onChanged,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(),
        // ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
      ),
    );
  }
}
