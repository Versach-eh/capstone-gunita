import 'package:flutter/material.dart';
import 'package:gunita20/ui/pages/fruit_memory_match_page.dart';
import 'package:gunita20/ui/widgets/game_button.dart';
import 'package:gunita20/utils/fruits_constants.dart';

class FruitGameOptions extends StatelessWidget {
  const FruitGameOptions({
    super.key,
  });

  static Route<dynamic> _routeBuilder(BuildContext context, int gameLevel) {
    return MaterialPageRoute(
      builder: (_) {
        return FruitMemoryMatchPage(gameLevel: gameLevel);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: gameLevels.map((level) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: GameButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                _routeBuilder(context, level['level']),
                (Route<dynamic> route) => false),
            title: level['title'],
            color: level['color']![700]!,
            width: 250,
          ),  
        );
      }).toList(),
    );
  }
}
