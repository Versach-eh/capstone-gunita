import 'package:flutter/material.dart';
import 'package:gunita20/screens/matching/fruit_the_memory_match_game.dart';
import 'package:gunita20/screens/matching/menu.dart';
// import 'package:gunita20/screens/matching/difficulty.dart';
import 'package:gunita20/screens/matching/the_memory_match_game.dart';
import 'package:gunita20/screens/matching/vegetables_the_memory_match_game.dart';


class CategoryMatchingMenuScreen extends StatefulWidget {
  const CategoryMatchingMenuScreen({Key? key}) : super(key: key);

  @override
  _MatchingMenuScreenState createState() => _MatchingMenuScreenState();
}

class _MatchingMenuScreenState extends State<CategoryMatchingMenuScreen> {


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
      child: Column(
        children: [
          SizedBox(height: 16.0),
          Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MatchingMenuScreen(),
                        ),
                      );
              },
              child: Container(
                margin: EdgeInsets.only(left: 30.0, top: 35.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffcE17612), // Changed from fcE17612 to cE17612
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
        Expanded( // Wrap the ListView in an Expanded widget
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                SizedBox(height: 30),
                Center(
                  child: Stack(
                    children: [
                      Text(
                        'CHOOSE ONE THEME:',
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
                    'CHOOSE ONE THEME:',
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
                          builder: (context) => VegetableTheMemoryMatchGame(),
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
                      "Vegetables",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                          builder: (context) => TheMemoryMatchGame(),
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
                      "Pets",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 32.0,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 20),
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
                          builder: (context) => FruitTheMemoryMatchGame(),
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
                      "Fruits",
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
        ]
      )
    )
    );
  }
}