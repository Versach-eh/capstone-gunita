import 'package:flutter/material.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';

class GameHistory extends StatefulWidget {
  const GameHistory({Key? key}) : super(key: key);

  @override
  _GameHistoryState createState() => _GameHistoryState();
}

class _GameHistoryState extends State<GameHistory> {
  double containerHeight1 = 130.0;
  double containerHeight2 = 130.0;
  double containerHeight3 = 130.0;// Initial height of the container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcF0F4FC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(15),
            color: Color(0xfffcF0F4FC),
            child: Column(
              children: [
                SizedBox(height: 40),
                Text(
                  'Your Game History',
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: 'Magdelin',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mindful Merge',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffc4530B2),
                        ),
                      ),
                    ),
                  ],
                ),
                // Positioned Container
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: containerHeight1,
                    width: 370,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Color(0xfffcF0F4FC),
                      border: Border.all(
                        color: Color(0xfffc4530B2),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildButton('EASY', buttonWidth: 100.0, buttonHeight: 50.0),
                            _buildButton('MEDIUM', buttonWidth: 100.0, buttonHeight: 50.0),
                            _buildButton('HARD', buttonWidth: 100.0, buttonHeight: 50.0),
                          ],
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: IconButton(
                            icon: Icon(
                              Icons.expand_more,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Handle the expand icon press
                              setState(() {
                                containerHeight1 = containerHeight1 == 130.0 ? 200.0 : 130.0; // Toggle between heights
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Word Wander',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffc4530B2),
                        ),
                      ),
                    ),
                  ],
                ),
                // Positioned Container
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: containerHeight2,
                    width: 370,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Color(0xfffcF0F4FC),
                      border: Border.all(
                        color: Color(0xfffc4530B2),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildButton('EASY', buttonWidth: 100.0, buttonHeight: 50.0),
                            _buildButton('MEDIUM', buttonWidth: 100.0, buttonHeight: 50.0),
                            _buildButton('HARD', buttonWidth: 100.0, buttonHeight: 50.0),
                          ],
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: IconButton(
                            icon: Icon(
                              Icons.expand_more,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Handle the expand icon press
                              setState(() {
                                containerHeight2 = containerHeight2 == 130.0 ? 200.0 : 130.0; // Toggle between heights
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Pair Play',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfffc4530B2),
                        ),
                      ),
                    ),
                  ],
                ),
                // Positioned Container
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: containerHeight3,
                    width: 370,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      color: Color(0xfffcF0F4FC),
                      border: Border.all(
                        color: Color(0xfffc4530B2),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildButton('EASY', buttonWidth: 100.0, buttonHeight: 50.0),
                            _buildButton('MEDIUM', buttonWidth: 100.0, buttonHeight: 50.0),
                            _buildButton('HARD', buttonWidth: 100.0, buttonHeight: 50.0),
                          ],
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: IconButton(
                            icon: Icon(
                              Icons.expand_more,
                              size: 30,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              // Handle the expand icon press
                              setState(() {
                                containerHeight3 = containerHeight3 == 130.0 ? 200.0 : 130.0; // Toggle between heights
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavigationButton(Icons.home, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }),
            _buildNavigationButton(Icons.games, () {
              // Handle the game library button click
            }),
            _buildNavigationButton(Icons.photo_album, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Album()),
              );
            }),
            _buildNavigationButton(Icons.settings, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySettings()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, {double buttonWidth = 100.0, double buttonHeight = 50.0}) {
  return Container(
    width: buttonWidth,
    height: buttonHeight,
    child: ElevatedButton(
      onPressed: () {
        // Handle button press
      },
      style: ElevatedButton.styleFrom(
        primary: Color(0xfffc4530B2),// Change the color as needed
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
        ),
      ),
      child: Text(label),
    ),
  );
}


  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: const Color(0xff959595),
      ),
      onPressed: onPressed,
    );
  }
}
