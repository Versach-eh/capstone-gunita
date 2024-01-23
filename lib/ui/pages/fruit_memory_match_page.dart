// import 'package:flutter/material.dart';
// import 'package:gunita20/ui/widgets/web/fruit_game_board.dart';
// import 'package:gunita20/ui/widgets/web/game_board.dart';
// import 'package:gunita20/ui/widgets/mobile/game_board_mobile.dart';

// class FruitMemoryMatchPage extends StatelessWidget {
//    FruitMemoryMatchPage({
//     required this.gameLevel,
//     required this.difficulty,
//     super.key,
//   });

//   final int gameLevel;
//   final int difficulty;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: ((context, constraints) {
//             if (constraints.maxWidth > 720) {
//               return FruitGameBoard(
//                 gameLevel: gameLevel,
//               );
//             } else {
//               return GameBoardMobile(
//                 gameLevel: gameLevel,
//                 difficulty: difficulty,
//               );
//             }
//           }),
//         ),
//       ),
//     );
//   }
// }
