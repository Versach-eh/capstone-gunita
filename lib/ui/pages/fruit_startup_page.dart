import 'package:flutter/material.dart';

import 'package:gunita20/ui/widgets/fruit_game_options.dart';
import 'package:gunita20/utils/fruits_constants.dart';

class FruitStartUpPage extends StatelessWidget {
  const FruitStartUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  gameTitle,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
                FruitGameOptions(),
              ]),
        ),
      ),
    );
  }
}
