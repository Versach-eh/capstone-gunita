  import 'package:flutter/material.dart';
import 'package:gunita20/screens/jigsaw/easy_scoreboard.dart';
import 'package:gunita20/screens/jigsaw/hard_scoreboard.dart';
import 'package:gunita20/screens/jigsaw/menu.dart';

  class MediumScoreboardScreen extends StatefulWidget {
    const MediumScoreboardScreen({Key? key}) : super(key: key);

    @override
    _MediumScoreboardScreenState createState() => _MediumScoreboardScreenState();
  }

  class _MediumScoreboardScreenState extends State<MediumScoreboardScreen> {
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
                            builder: (context) => JigsawMenuScreen(),
                          ),
                        );
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 30.0, top: 35.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xfffcE17612),
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
              SizedBox(height: 30),
              Center(
                child: Stack(
                  children: [
                    Text(
                      'SCOREBOARD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 42.0,
                        fontFamily: 'kg_inimitable_original',
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..color = Colors.black
                          ..strokeWidth = 4,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(1.0),
                            offset: Offset(0, 6),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'SCOREBOARD',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 42.0,
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
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xfffcE17612).withOpacity(1.0),
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
                        fixedSize: Size(165, 45),
                        primary: Color(0xfffcE17612),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Easy",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xfffcE17612).withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => CategoryMatchingMenuScreen(),
                        //   ),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(165, 45),
                        primary: Color(0xfffcFFDE59), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Medium",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.black,
                          fontSize: 28.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xfffcE17612).withOpacity(1.0),
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
                        builder: (context) => HardScoreboardScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(165, 45),
                    primary: Color(0xfffcE17612), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.white,
                        width: 3.0,
                      ),
                    ),
                  ),
                  child: Text(
                    "Hard",
                    style: TextStyle(
                      fontFamily: 'purple_smile',
                      color: Colors.white,
                      fontSize: 28.0,
                    ),
                  ),
                ),
              ),
            SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // Adjusted alignment
              children: [
                 Container(
              width: 220,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(right: 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circle
                  Positioned(
                    left: 10, // Adjust the left position as needed
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfffcE17612), // Customize the circle color
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '01',
                        style: TextStyle(
                          color: Colors.white, 
                           fontSize: 24.0,
                          fontFamily: 'kg_inimitable_original',// Customize the text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
                Container(
                  width: 120,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xfffcFFDE59),
                  ),
                  margin: EdgeInsets.only(left: 0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
               Row(
              mainAxisAlignment: MainAxisAlignment.center, // Adjusted alignment
              children: [
                 Container(
              width: 220,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(right: 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circle
                  Positioned(
                    left: 10, // Adjust the left position as needed
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfffcE17612), // Customize the circle color
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '02',
                        style: TextStyle(
                          color: Colors.white, 
                           fontSize: 24.0,
                          fontFamily: 'kg_inimitable_original',// Customize the text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
                Container(
                  width: 120,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xfffcFFDE59),
                  ),
                  margin: EdgeInsets.only(left: 0),
                ),
              ],
            ),
            SizedBox(height: 10.0),
                Row(
              mainAxisAlignment: MainAxisAlignment.center, // Adjusted alignment
              children: [
                 Container(
              width: 220,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(right: 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Circle
                  Positioned(
                    left: 10, // Adjust the left position as needed
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xfffcE17612), // Customize the circle color
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '03',
                        style: TextStyle(
                          color: Colors.white, 
                           fontSize: 24.0,
                          fontFamily: 'kg_inimitable_original',// Customize the text color
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
                Container(
                  width: 120,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xfffcFFDE59),
                  ),
                  margin: EdgeInsets.only(left: 0),
                ),
              ],
            ),
              SizedBox(height: 30.0),
           ],
        ),
      ),
    );
  }
}