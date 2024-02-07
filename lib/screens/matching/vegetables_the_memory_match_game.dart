import 'package:flutter/material.dart';
// import 'package:gunita20/screens/matching/difficulty.dart';
import 'package:gunita20/screens/matching/vegetable_difficulty.dart';
// import 'package:gunita20/ui/pages/startup_page.dart';

class VegetableTheMemoryMatchGame extends StatelessWidget {
  const VegetableTheMemoryMatchGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VegetableMatchingDifficultyScreen(),
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
