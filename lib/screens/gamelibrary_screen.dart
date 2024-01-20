import 'package:flutter/material.dart';
// import 'package:gunita20/screens/jigzaw.dart';
import 'package:gunita20/screens/matching/menu.dart';
import 'package:gunita20/screens/jigsaw/menu.dart';
import 'package:gunita20/screens/crossword/word_menu.dart';
import 'package:shimmer/shimmer.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';
// import 'package:gunita20/screens/matching/the_memory_match_game.dart';
// import 'package:gunita20/screens/crossword/crossword.dart';

class GameLibrary extends StatefulWidget {
  const GameLibrary({Key? key}) : super(key: key);

  @override
  _GameLibraryState createState() => _GameLibraryState();
}

class _GameLibraryState extends State<GameLibrary> {
  List<Map<String, dynamic>> gif = [
    {'path': 'assets/images/jigsaw.gif'},
    {'path': 'assets/images/wordsearch.gif'},
    {'path': 'assets/images/mam.gif'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(20),
              color: Color.fromARGB(255, 254, 254, 255),
              child: Column(
                children: [
                  SizedBox(height: 40),
                  Text(
                    'Library of Games',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),

            // Images Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: gif.map((imageData) {
                  return GestureDetector(
                    onTap: () {
                      // Use Navigator to navigate to the desired screen based on the image
                      if (imageData['path'] == 'assets/images/jigsaw.gif') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => JigsawMenuScreen()),
                        );
                      } else if (imageData['path'] == 'assets/images/wordsearch.gif') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CrosswordMenuScreen()),
                        );
                      } else if (imageData['path'] == 'assets/images/mam.gif') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MatchingMenuScreen()),
                        );
                      }
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: AspectRatio(
                              aspectRatio: 16 / 7,
                              child: Image.asset(
                                imageData['path'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 8,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  'Play', // Replace with your desired text
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
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

  // Helper method to build navigation buttons
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

class JigsawScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jigsaw Screen'),
      ),
      body: Center(
        child: Text('This is the Jigsaw Screen'),
      ),
    );
  }
}

class WordSearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Search Screen'),
      ),
      body: Center(
        child: Text('This is the Word Search Screen'),
      ),
    );
  }
}

class MamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mam Screen'),
      ),
      body: Center(
        child: Text('This is the Mam Screen'),
      ),
    );
  }
}
