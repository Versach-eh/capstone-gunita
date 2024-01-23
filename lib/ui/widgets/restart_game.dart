import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gunita20/screens/matching/difficulty.dart';
import 'package:gunita20/ui/pages/startup_page.dart';
import 'package:gunita20/ui/widgets/game_controls_bottomsheet.dart';

class RestartGame extends StatelessWidget {
  const RestartGame({
    required this.isGameOver,
    required this.pauseGame,
    required this.restartGame,
    required this.continueGame,
    required this.resetGame,
    this.color = Colors.white,
    super.key,
  });

  final VoidCallback pauseGame;
  final VoidCallback restartGame;
  final VoidCallback continueGame;
  final VoidCallback resetGame;
  final bool isGameOver;
  final Color color;

  Future<void> showGameControls(BuildContext context) async {
    pauseGame();
    var value = await showModalBottomSheet<bool>(
      isScrollControlled: true,
      elevation: 5,
      context: context,
      builder: (sheetContext) {
        return const GameControlsBottomSheet();
      },
    );

    value ??= false;

    if (value) {
      restartGame();
    } else {
      continueGame();
    }
  }

  void navigateback(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
      return const MatchingDifficultyScreen();
    }), (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            color: color,
            icon: (isGameOver)
                ? const Icon(Icons.pause_circle_filled)
                : const Icon(Icons.pause_circle_filled),
            iconSize: 40,
            onPressed: () {
              if (isGameOver) {
                navigateback(context);
              } else {
                showGameControls(context);
              }
            },
          ),
          IconButton(
            iconSize: 40,
            color: color,
            icon: const Icon(Icons.refresh),
            onPressed: resetGame,
          ),
        ],
      ),
    );
  }
}
