import 'package:flutter/material.dart';

enum CardState { hidden, visible, guessed }

class CardItem {
  CardItem({
    required this.value,
    required this.imagePath, // Change from IconData to String
    required this.color,
    this.state = CardState.hidden,
  });

  final int value;
  final String imagePath; // Change from IconData to String
  final Color color;
  CardState state;
}


// class CardItem {
//   CardItem({
//     required this.value,
//     required this.icon,
//     required this.color,
//     this.state = CardState.hidden,
//   });

//   final int value;
//   final String imagePath
//   final Color color;
//   CardState state;
// }
