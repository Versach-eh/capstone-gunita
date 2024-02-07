import 'package:flutter/material.dart';
import 'package:gunita20/screens/crossword/fruits.dart';
import 'package:gunita20/screens/crossword/hard_fruits.dart';
import 'package:gunita20/screens/crossword/hard_pets.dart';
import 'package:gunita20/screens/crossword/hard_vegie.dart';
import 'package:gunita20/screens/crossword/moderate_pets.dart';
import 'package:gunita20/screens/crossword/pets.dart';
import 'package:gunita20/screens/crossword/vegie.dart';
import 'package:gunita20/screens/crossword/word_category.dart';

class HardThemesMenuScreen extends StatefulWidget {
  const HardThemesMenuScreen({Key? key}) : super(key: key);

  @override
  _HardThemesMenuScreenState createState() => _HardThemesMenuScreenState();
}

class _HardThemesMenuScreenState extends State<HardThemesMenuScreen> {
  
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
                          builder: (context) => CategoryWordMenuScreen(
                          ),
                        ),
                      );
                },
                child: Container(
                  margin: EdgeInsets.only(left: 30.0, top: 35.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        Color(0xffcE17612), // Changed from fcE17612 to cE17612
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
            SizedBox(height: 30), // Removed extra SizedBox
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                   
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HardPetsScreen(
                            difficulty: 0,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(280, 75),
                      primary: Color(
                          0xffc36C655), // Changed from fc36C655 to c36C655
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "PETS",
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HardFruitsScreen(
                            difficulty: 2,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(280, 75),
                      primary: Color(
                          0xffc36C655), // Changed from fc36C655 to c36C655
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "FRUITS",
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HardVegieScreen(
                            difficulty: 2,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(280, 75),
                      primary: Color(
                          0xffc36C655), // Changed from fc36C655 to c36C655
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "VEGGIES",
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
