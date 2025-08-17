import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.buttonText,
    required this.ontap,
    required this.Color
  });

  final String buttonText;
  final VoidCallback? ontap;
    final  Color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Expanded(
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: Color,
            borderRadius: BorderRadius.circular(18.00),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
