import 'package:flutter/material.dart';

void showMessage({required BuildContext context, required String text}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.blue,
      content: Text(text, style: const TextStyle(fontSize: 15)),
    ),
  );
}
