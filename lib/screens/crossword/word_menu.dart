import 'package:flutter/material.dart';
import 'package:gunita20/screens/crossword/word_category.dart';
import 'package:gunita20/screens/crossword/instruction.dart';
import 'package:gunita20/screens/crossword/word_easy_scoreboard.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';

class CrosswordMenuScreen extends StatefulWidget {
  const CrosswordMenuScreen({Key? key}) : super(key: key);

  @override
  _CrosswordMenuScreenState createState() => _CrosswordMenuScreenState();
}

class _CrosswordMenuScreenState extends State<CrosswordMenuScreen> {
  Future<void> _showQuitConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Color(0xfffcE17612), width: 7.0),
          ),
          backgroundColor:
              Color(0xfffcFFF9E3), // Set your custom background color here
          title: Text(
            'Are you sure you want to quit?',
            style: TextStyle(
              fontFamily: 'purple_smile',
              fontSize: 28.0,
              color: Colors.black, // Set the text color
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
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
                    Navigator.of(context).pop(); // Dismiss the dialog
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
                    "NO",
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
                    "YES",
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/word_wander.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            SizedBox(height: 90),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      Text(
                        'WORD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 62.0,
                          fontFamily: 'kg_inimitable_original',
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..color = Color(0xfffcC04A4A)
                            ..strokeWidth = 12,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(251, 155, 11, 11)
                                  .withOpacity(1.0),
                              offset: Offset(11, 11),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'WORD',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 62.0,
                          fontFamily: 'kg_inimitable_original',
                          color: Colors.white,
                          // shadows: [
                          //   // Shadow(
                          //   //   color: Colors.black.withOpacity(0.5),
                          //   //   offset: Offset(0, 0),
                          //   //   blurRadius: 0,
                          //   // ),
                          // ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Stack(
                    children: [
                      Text(
                        'WANDER',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 62.0,
                          fontFamily: 'kg_inimitable_original',
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..color = Color(0xfffcC04A4A)
                            ..strokeWidth = 12,
                          shadows: [
                            Shadow(
                              color: Color.fromARGB(251, 155, 11, 11)
                                  .withOpacity(1.0),
                              offset: Offset(11, 11),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'WANDER',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 62.0,
                          fontFamily: 'kg_inimitable_original',
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(0, 0),
                              blurRadius: 0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Button 1
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryWordMenuScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(280, 75),
                      primary: Color(0xfffc36C655),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "Lets Play!",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Button 2
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InstructionsScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(280, 75),
                      primary: Color(0xfffc36C655),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "How to Play?",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),
                // Button 3
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EasyScoreboardScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(280, 75),
                      primary: Color(0xfffc36C655),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "Scoreboard",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Button 4
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Show the quit confirmation dialog
                      _showQuitConfirmationDialog();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(280, 75),
                      primary: Color(0xfffcD63131),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "Quit",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
