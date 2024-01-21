import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/matching/category.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';

class GameConfetti extends StatefulWidget {
  final Duration gameTime;

  const GameConfetti({
    Key? key,
    required this.gameTime,
  }) : super(key: key);

  @override
  State<GameConfetti> createState() => _GameConfettiState();
}

class _GameConfettiState extends State<GameConfetti> {
  final controllerCenter =
      ConfettiController(duration: const Duration(seconds: 10));

  late BuildContext popupContext;
  late Duration gameTime; // Store the time taken in the game

  @override
  void initState() {
    super.initState();
    gameTime = widget.gameTime; // Assign the correct value here
    controllerCenter.play();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      showCongratulationsPopup(context, gameTime);
    });
  }

  void showCongratulationsPopup(BuildContext context, Duration gameTime) {
    popupContext = context;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(color: Color(0xfffcE17612), width: 7.0),
          ),
          backgroundColor: Colors.white, // Change to white
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 300.0, // Adjusted width
                padding:
                    EdgeInsets.symmetric(vertical: 15.0), // Adjusted padding
                decoration: BoxDecoration(
                  color: Color(0xfffcFFDE59), // Ribbon background color
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.0),
                    topRight: Radius.circular(12.0),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Congratulations!',
                    style: TextStyle(
                        color: Color(0xfffcE17612),
                        fontFamily: 'purple_smile',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Text(
                'Your score is ${formatDuration(gameTime)}!',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'purple_smile',
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade800.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        playAgain();
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(230, 50),
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
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.shade800.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameLibrary(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(230, 50),
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
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  String formatDuration(Duration duration) {
    // Format the duration as per your requirement
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void playAgain() {
    Navigator.pushReplacement(
      popupContext,
      MaterialPageRoute(
          builder: (BuildContext context) => CategoryMatchingMenuScreen()),
    );
  }

  // void quitGame() {
  //   Navigator.pushReplacement(
  //     popupContext,
  //     MaterialPageRoute(builder: (BuildContext context) => GameLibrary()),
  //   );
  // }

  @override
  void dispose() {
    controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          ConfettiWidget(
            confettiController: controllerCenter,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            gravity: 0.5,
            emissionFrequency: 0.05,
            numberOfParticles: 20,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple,
            ],
          ),
        ],
      ),
    );
  }
}
