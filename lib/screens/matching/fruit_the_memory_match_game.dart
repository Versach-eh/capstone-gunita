import 'package:flutter/material.dart';
import 'package:gunita20/screens/matching/fruit_difficulty.dart';

class FruitTheMemoryMatchGame extends StatelessWidget {
  const FruitTheMemoryMatchGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FruitMatchingDifficultyScreen(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
