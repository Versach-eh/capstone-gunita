import 'package:flutter/material.dart';
import 'package:gunita20/game_history/history.dart';
import 'package:gunita20/screens/crossword/word_menu.dart';
import 'package:gunita20/screens/jigsaw/menu.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/matching/menu.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';

class GameLibrary extends StatefulWidget {
  const GameLibrary({Key? key}) : super(key: key);

  @override
  _GameLibraryState createState() => _GameLibraryState();
}

class _GameLibraryState extends State<GameLibrary> {
  List<Map<String, dynamic>> gif = [
    {
      'path': 'assets/images/jigsaw.gif',
      'line1': 'Mindful Merge',
      'line2': 'Piece by piece, a memory is built!'
    },
    {
      'path': 'assets/images/wordsearch.gif',
      'line1': 'Word Wander',
      'line2': 'Discover delight in every word.'
    },
    {
      'path': 'assets/images/mam.gif',
      'line1': 'Pair Play',
      'line2': 'Lets match some moments!'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcF0F4FC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section with Background Image
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/game.png'), // replace with your image path
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 50),
                      Text(
                        'Your Game Library',
                        style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Magdelin',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                  top: 40,
                  right: 10,
                  child: Container(
                    width: 52, // Adjust this value to change the width and size of the circle
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xfffc4530B2), // Change the color to your desired color
                    ),
                    padding: EdgeInsets.all(2),
                    child: IconButton(
                      icon: Icon(
                        Icons.analytics_outlined,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GameHistory()),
                        );
                      },
                    ),
                  ),
                ),
                ],
              ),
            ),

            // Images Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: gif.map((imageData) {
                  return GestureDetector(
                    onTap: () {
                      // Use Navigator to navigate to the desired screen based on the image
                      if (imageData['path'] == 'assets/images/jigsaw.gif') {
                        // Customize the navigation logic for Jigsaw
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JigsawMenuScreen()),
                        );
                      } else if (imageData['path'] ==
                          'assets/images/wordsearch.gif') {
                        // Customize the navigation logic for Word Search
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CrosswordMenuScreen()),
                        );
                      } else if (imageData['path'] == 'assets/images/mam.gif') {
                        // Customize the navigation logic for Mam
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MatchingMenuScreen()),
                        );
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Two lines of text
                        Text(
                          imageData['line1'],
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontFamily: 'Magdelin',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          imageData['line2'],
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: 'Magdelin',
                          ),
                          textAlign: TextAlign.left,
                        ),
                        // GIF
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: AspectRatio(
                                  aspectRatio: 18 / 7,
                                  child: Image.asset(
                                    imageData['path'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 1,
                                right: 8,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Customize the 'PLAY' button logic based on the image
                                    if (imageData['path'] ==
                                        'assets/images/jigsaw.gif') {
                                      // Customize the 'PLAY' button logic for Jigsaw
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JigsawMenuScreen()),
                                      );
                                    } else if (imageData['path'] ==
                                        'assets/images/wordsearch.gif') {
                                      // Customize the 'PLAY' button logic for Word Search
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CrosswordMenuScreen()),
                                      );
                                    } else if (imageData['path'] ==
                                        'assets/images/mam.gif') {
                                      // Customize the 'PLAY' button logic for Mam
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MatchingMenuScreen()),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        Color(0xfffc4530B2).withOpacity(0.9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 28, vertical: 5),
                                  ),
                                  child: Text(
                                    'PLAY',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontFamily: 'Magdelin',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
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

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: Color.fromARGB(255, 133, 133, 133),
      ),
      onPressed: onPressed,
    );
  }
}
