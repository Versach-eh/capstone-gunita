// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import 'package:gunita20/models/game.dart';

// import 'package:gunita20/ui/widgets/game_confetti.dart';

// import 'package:gunita20/ui/widgets/memory_card.dart';
// // import 'package:gunita20/ui/widgets/mobile/game_best_time_mobile.dart';
// import 'package:gunita20/ui/widgets/mobile/game_timer_mobile.dart';
// import 'package:gunita20/ui/widgets/restart_game.dart';

// class FruitGameBoardMobile extends StatefulWidget {
//   const FruitGameBoardMobile({
//     required this.gameLevel,
//     Key? key,
//   }) : super(key: key);

//   final int gameLevel;

//   @override
//   State<FruitGameBoardMobile> createState() => _FruitGameBoardMobileState();
// }

// class _FruitGameBoardMobileState extends State<FruitGameBoardMobile> {
//   late Timer timer = Timer(Duration(seconds: 0), () {}); // Initialize with an empty timer
//   late Game game;
//   late Duration duration;
//   int bestTime = 0;
//   bool showConfetti = false;
//   bool isGameStarted = false;

//   @override
//   void initState() {
//     super.initState();
//     game = Game(widget.gameLevel);
//     duration = const Duration();
//     getBestTime();
//   }

//   void getBestTime() async {
//     SharedPreferences gameSP = await SharedPreferences.getInstance();
//     if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') != null) {
//       bestTime = gameSP.getInt('${widget.gameLevel.toString()}BestTime')!;
//     }
//     setState(() {});
//   }

//   void startGame() {
//     setState(() {
//       isGameStarted = true;
//     });
//     startTimer();
//   }

//   @override
//   void dispose() {
//     if (timer.isActive) {
//       timer.cancel();
//     }
//     super.dispose();
//   }

//   void startTimer() {
//   if (!isGameStarted) {
//     return;
//   }

//   timer = Timer.periodic(const Duration(seconds: 1), (_) async {
//     if (!mounted) {
//       // Check if the widget is still mounted before calling setState
//       return;
//     }

//     setState(() {
//       final seconds = duration.inSeconds + 1;
//       duration = Duration(seconds: seconds);
//     });

// void _showCongratulationsPopup(Duration gameTime) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => GameConfetti(gameTime: gameTime),
//     ),
//   );
// }

//     if (game.isGameOver) {
//   timer.cancel();
//   SharedPreferences gameSP = await SharedPreferences.getInstance();
//   if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') == null ||
//       gameSP.getInt('${widget.gameLevel.toString()}BestTime')! >
//           duration.inSeconds) {
//     gameSP.setInt(
//         '${widget.gameLevel.toString()}BestTime', duration.inSeconds);
//     setState(() {
//       showConfetti = true;
//       bestTime = duration.inSeconds;
//     });
//     _showCongratulationsPopup(duration); // Pass the duration to GameConfetti
//   } else {
//     // If the game is over but the current time is not the best time,
//     // still show confetti.
//     setState(() {
//       showConfetti = true;
//         });
//       }
//     }
//   });
// }

//   void pauseTimer() {
//     if (isGameStarted && timer != null && timer.isActive) {
//       timer.cancel();
//       setState(() {
//         isGameStarted = false;
//       });
//     }
//   }

//   void _resetGame() async {
//     game.resetGame();
//     if (timer.isActive) {
//       timer.cancel();
//     }
//     setState(() {
//       duration = const Duration();
//       isGameStarted = false;
//       bestTime = 0; // Reset best time locally
//     });

//     SharedPreferences gameSP = await SharedPreferences.getInstance();
//     gameSP.remove('${widget.gameLevel.toString()}BestTime'); // Clear best time in SharedPreferences
//   }

//   @override
//   Widget build(BuildContext context) {
//     final aspectRatio = MediaQuery.of(context).size.aspectRatio;

//     return SafeArea(
//       child: Stack(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//              RestartGame(
//                   isGameOver: game.isGameOver,
//                   pauseGame: () => pauseTimer(),
//                   restartGame: () => _resetGame(),
//                   continueGame: () => startTimer(),
//                   resetGame: () => _resetGame(),
//                   color: Colors.greenAccent[700]!,
//                 ),
//               GameTimerMobile(
//                 time: duration,
//               ),
//               Expanded(
//                 child: GridView.builder(
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: game.gridSize,
//                     childAspectRatio: aspectRatio * 2, // Adjust the aspect ratio
//                   ),
//                   itemBuilder: (context, index) {
//                     return MemoryCard(
//                       index: index,
//                       card: game.cards[index],
//                       onCardPressed: game.onCardPressed,
//                     );
//                   },
//                   itemCount: game.cards.length,
//                 ),
//               ),
//               // GameBestTimeMobile(
//               //   bestTime: bestTime,
//               // ),
//             ],
//           ),
//           showConfetti ? GameConfetti(gameTime: duration) : const SizedBox(),

//           Positioned(
//             bottom: 110.0,
//             left: MediaQuery.of(context).size.width / 2 - 140.0,
//             child: !isGameStarted
//                 ? Container(
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.green.shade800.withOpacity(1.0),
//                           spreadRadius: 1,
//                           blurRadius: 1,
//                           offset: Offset(0, 6),
//                         ),
//                       ],
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: ElevatedButton(
//                       onPressed: startGame,
//                       style: ElevatedButton.styleFrom(
//                         fixedSize: const Size(280, 60),
//                         primary: const Color(0xfffc36C655),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                           side: const BorderSide(
//                             color: Colors.white,
//                             width: 3.0,
//                           ),
//                         ),
//                       ),
//                       child: Text(
//                         "Let's Start!",
//                         style: TextStyle(
//                           fontFamily: 'purple_smile',
//                           color: Colors.white,
//                           fontSize: 30.0,
//                         ),
//                       ),
//                     ),
//                   )
//                 : SizedBox(),
//           ),
//         ],
//       ),
//     );
//   }
// }