import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gunita20/models/card_item.dart';
import 'package:gunita20/utils/icons.dart';

class Game {
  Game(this.gridSize) {
    generateCards();
  }
  final int gridSize;

  List<CardItem> cards = [];
  bool isGameOver = false;
  Set<String> icons = {};

  void generateCards() {
    generateIcons();
    cards = [];
    final List<Color> cardColors = Colors.primaries.toList();
    for (int i = 0; i < (gridSize * gridSize / 2); i++) {
      final cardValue = i + 1;
      final String imagePath = icons.elementAt(i);
      final Color cardColor = cardColors[i % cardColors.length];
      final List<CardItem> newCards =
    _createCardItems(animalImages[i], cardColor, cardValue);

      cards.addAll(newCards);
    }
    cards.shuffle(Random());
  }

 void generateIcons() {
  icons = <String>{};
  for (int j = 0; j < (gridSize * gridSize / 2); j++) {
    final String imagePath = _getRandomImagePath();
    icons.add(imagePath);
    icons.add(imagePath); // Add the image path twice to ensure pairs are generated.
  }
}



  void resetGame() {
    generateCards();
    isGameOver = false;
  }

  void onCardPressed(int index) {
    cards[index].state = CardState.visible;
    final List<int> visibleCardIndexes = _getVisibleCardIndexes();
    if (visibleCardIndexes.length == 2) {
      final CardItem card1 = cards[visibleCardIndexes[0]];
      final CardItem card2 = cards[visibleCardIndexes[1]];
      if (card1.value == card2.value) {
        card1.state = CardState.guessed;
        card2.state = CardState.guessed;
        isGameOver = _isGameOver();
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          card1.state = CardState.hidden;
          card2.state = CardState.hidden;
        });
      }
    }
  }

  List<CardItem> _createCardItems(
      String imagePath, Color cardColor, int cardValue) {
    return List.generate(
      2,
      (index) => CardItem(
        value: cardValue,
        imagePath: imagePath,
        color: cardColor,
      ),
    );
  }

  String _getRandomImagePath() {
  final Random random = Random();
  String imagePath;
  do {
    imagePath = animalImages[random.nextInt(animalImages.length)];
  } while (icons.contains(imagePath));
  return imagePath;
}

  List<int> _getVisibleCardIndexes() {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.state == CardState.visible)
        .map((entry) => entry.key)
        .toList();
  }

  bool _isGameOver() {
    return cards.every((card) => card.state == CardState.guessed);
  }
}
