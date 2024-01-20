import 'package:flutter/material.dart';
import 'package:gunita20/ui/widgets/web/fruit_game_board.dart';
import 'package:gunita20/ui/widgets/mobile/fruit_game_board_mobile.dart';

class FruitMemoryMatchPage extends StatelessWidget {
  const FruitMemoryMatchPage({
    required this.gameLevel,
    super.key,
  });

  final int gameLevel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: ((context, constraints) {
            if (constraints.maxWidth > 720) {
              return FruitGameBoard(
                gameLevel: gameLevel,
              );
            } else {
              return FruitGameBoardMobile(
                gameLevel: gameLevel,
              );
            }
          }),
        ),
      ),
    );
  }
}
