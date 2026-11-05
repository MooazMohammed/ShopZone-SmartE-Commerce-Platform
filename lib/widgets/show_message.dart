import 'package:flutter/material.dart';

ScaffoldFeatureController showMessage({required context, required text}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.blue,
      content: Text(
        '$text',
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    ),
  );
}