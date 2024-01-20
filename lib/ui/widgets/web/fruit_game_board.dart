import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gunita20/models/game.dart';
import 'package:gunita20/ui/widgets/game_confetti.dart';

import 'package:gunita20/ui/widgets/memory_card.dart';
import 'package:gunita20/ui/widgets/restart_game.dart';
import 'package:gunita20/ui/widgets/web/game_best_time.dart';
import 'package:gunita20/ui/widgets/web/game_timer.dart';

class FruitGameBoard extends StatefulWidget {
  const FruitGameBoard({
    required this.gameLevel,
    Key? key,
  }) : super(key: key);

  final int gameLevel;

  @override
  State<FruitGameBoard> createState() => _FruitGameBoardState();
}

class _FruitGameBoardState extends State<FruitGameBoard> {
late Timer timer = Timer(Duration(seconds: 0), () {}); // Initialize with an empty timer
  late Game game;
  late Duration duration;
   int secondsElapsed = 0;
  bool isGameStarted = false;
  bool isGamePaused = false;
  String currentWord = '';
  DateTime startTime = DateTime.now();
  Duration get gameTime => DateTime.now().difference(startTime);

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void initState() {
    super.initState();
    game = Game(widget.gameLevel);
    duration = const Duration();
    // getBestTime();
  }

  // void getBestTime() async {
  //   SharedPreferences gameSP = await SharedPreferences.getInstance();
  //   if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') != null) {
  //     bestTime = gameSP.getInt('${widget.gameLevel.toString()}BestTime')!;
  //   }
  //   setState(() {});
  // }

  void startGame() {
    setState(() {
      isGameStarted = true;
    });
    startTimer();
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  void startTimer() {
  if (!isGameStarted) {
    return;
  }

  timer = Timer.periodic(const Duration(seconds: 1), (_) async {
    if (!mounted) {
      // Check if the widget is still mounted before calling setState
      return;
    }

    setState(() {
      final seconds = duration.inSeconds + 1;
      duration = Duration(seconds: seconds);
    });

    void stopTimer() {
    timer.cancel();
  }

    void stopGame() {
    stopTimer();
    isGamePaused = true;
  }

  void playAgain() {
  // Add logic to reset the game or navigate to a new game
  setState(() {
    // Reset the game state
    isGameStarted = false;
    isGamePaused = false;
    secondsElapsed = 0;
  });
}

void showCongratulationsDialog(BuildContext context, Duration gameTime) {
  // Stop the game when all words are matched
  stopGame();

  showDialog( 
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: Color(0xfffcE17612), width: 7.0),
        ),
        backgroundColor: Colors.white, // Change to white
        child: Container(
          width: 300.0, // Adjusted width
          padding: EdgeInsets.symmetric(vertical: 15.0), // Adjusted padding
          decoration: BoxDecoration(
            color: Color(0xfffcFFDE59), // Ribbon background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Congratulations!',
                style: TextStyle(
                  color: Color(0xfffcE17612),
                  fontFamily: 'purple_smile',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Your score is ${formatDuration(gameTime)}!',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'purple_smile',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      playAgain();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 50),
                      primary: Color(0xfffc36C655),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                      shadowColor: Colors.green.shade800.withOpacity(0.8),
                      elevation: 5,
                    ),
                    child: Text(
                      "Play again",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameLibrary(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 50),
                      primary: Color(0xfffcD63131),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                      shadowColor: Colors.red.shade800.withOpacity(0.8),
                      elevation: 5,
                    ),
                    child: Text(
                      "Quit",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

  //   if (game.isGameOver) {
  // timer.cancel();
  // SharedPreferences gameSP = await SharedPreferences.getInstance();
  // if (gameSP.getInt('${widget.gameLevel.toString()}BestTime') == null ||
  //     gameSP.getInt('${widget.gameLevel.toString()}BestTime')! >
  //         duration.inSeconds) {
  //   gameSP.setInt(
  //       '${widget.gameLevel.toString()}BestTime', duration.inSeconds);
  //   setState(() {
  //     showConfetti = true;
  //     bestTime = duration.inSeconds;
  //   });
  //   _showCongratulationsPopup(duration); // Pass the duration to GameConfetti
  // } else {
  //   // If the game is over but the current time is not the best time,
  //   // still show confetti.
  //   setState(() {
  //     showConfetti = true;
  //       });
  //     }
  //   }
  });
}

  void pauseTimer() {
    if (isGameStarted && timer != null && timer.isActive) {
      timer.cancel();
      setState(() {
        isGameStarted = false;
      });
    }
  }

  void _resetGame() async {
    game.resetGame();
    if (timer.isActive) {
      timer.cancel();
    }
    setState(() {
      duration = const Duration();
      isGameStarted = false;
      // bestTime = 0; // Reset best time locally
    });

    SharedPreferences gameSP = await SharedPreferences.getInstance();
    gameSP.remove('${widget.gameLevel.toString()}BestTime'); // Clear best time in SharedPreferences
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = MediaQuery.of(context).size.aspectRatio;

    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
             RestartGame(
                  isGameOver: game.isGameOver,
                  pauseGame: () => pauseTimer(),
                  restartGame: () => _resetGame(),
                  continueGame: () => startTimer(),
                  resetGame: () => _resetGame(),
                  color: Colors.greenAccent[700]!,
                ),
              // Add a reset button here
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: _resetGame,
              ),
            ],
          ),
        ]
        ),
      //   Positioned(
      //   bottom: 12.0,
      //   right: 24.0,
      //   child: GameTimer(
      //     time: duration,
      //   ),
      // ),
        // Positioned(
        //   bottom: 12.0,
        //   left: 24.0,
        //   child: GameBestTime(
        //     bestTime: bestTime,
        //   ),
        // ),
        // showConfetti ? GameConfetti(gameTime: duration) : const SizedBox(),
    

    );
  }
}
