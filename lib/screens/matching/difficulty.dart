import 'package:flutter/material.dart';
import 'package:gunita20/screens/matching/category.dart';
// import 'package:gunita20/screens/matching/category.dart';
import 'package:gunita20/ui/pages/memory_match_page.dart';

class MatchingDifficultyScreen extends StatefulWidget {
  const MatchingDifficultyScreen({Key? key}) : super(key: key);

  @override
  _MatchingDifficultyScreenState createState() =>
      _MatchingDifficultyScreenState();
}

class _MatchingDifficultyScreenState extends State<MatchingDifficultyScreen> {
  final List<Map<String, dynamic>> gameLevels = [
    {
      'title': 'Easy',
      'level': 2,
      'color': Color(0xfffc36C655),
      'difficulty': 0
    },
    {
      'title': 'Medium',
      'level': 3,
      'color': Color(0xfffc36C655),
      'difficulty': 1
    },
    {
      'title': 'Hard',
      'level': 4,
      'color': Color(0xfffc36C655),
      'difficulty': 2
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/pair_play.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: [
        SizedBox(height: 16.0),
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () {
             Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryMatchingMenuScreen(),
                        ),
                      );
            },
            child: Container(
              margin: EdgeInsets.only(left: 30.0, top: 35.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffcE17612),
              ),
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 32.0,
              ),
            ),
          ),
        ),
        SizedBox(height: 50), // Removed extra SizedBox
        Center(
          child: Stack(
            children: [
              Text(
                'CHOOSE ONE MODE:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'kg_inimitable_original',
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..color = Colors.black
                    ..strokeWidth = 4,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(1.0),
                      offset: Offset(1, 7.5),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              Text(
                'CHOOSE ONE MODE:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40.0,
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
        ),
        SizedBox(height: 60),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: gameLevels.map((level) {
            return Column(
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to MemoryMatchPage and pass the selected game level
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MemoryMatchPage(
                            gameLevel: level['level'],
                            difficulty: level['difficulty'],
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(280, 75),
                      primary: level['color'],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Text(
                      level['title'],
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0), // Adjust the height as needed
              ],
            );
          }).toList(),
        ),
      ]),
    ));
  }
}
