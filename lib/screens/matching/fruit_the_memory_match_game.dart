import 'package:flutter/material.dart';
// import 'package:gunita20/screens/matching/difficulty.dart';
import 'package:gunita20/screens/matching/fruit_difficulty.dart';
// import 'package:gunita20/ui/pages/startup_page.dart';

class FruitTheMemoryMatchGame extends StatelessWidget {
  const FruitTheMemoryMatchGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FruitMatchingDifficultyScreen(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
