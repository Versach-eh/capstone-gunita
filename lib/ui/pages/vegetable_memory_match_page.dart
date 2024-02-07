import 'package:flutter/material.dart';
import 'package:gunita20/ui/widgets/mobile/vegetable_game_board_mobile.dart';
import 'package:gunita20/ui/widgets/web/vegetable_game_board.dart';

class VegetableMemoryMatchPage extends StatelessWidget {
  const VegetableMemoryMatchPage({
    required this.gameLevel,
    required this.difficulty,
    super.key,
  });

  final int gameLevel;
  final int difficulty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: ((context, constraints) {
            if (constraints.maxWidth > 720) {
              return VegetableGameBoard(
                gameLevel: gameLevel,
              );
            } else {
              return VegetableGameBoardMobile(
                gameLevel: gameLevel,
                difficulty: difficulty,
              );
            }
          }),
        ),
      ),
    );
  }
}
