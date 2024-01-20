import 'package:flutter/material.dart';

class GameTimer extends StatelessWidget {
  const GameTimer({
    required this.time,
    Key? key, // Corrected key definition
  }) : super(key: key); // Use super(key: key)

  final Duration time;

  @override
  Widget build(BuildContext context) {
    return Text(
      time.toString().split('.').first.padLeft(8, "0"),
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
