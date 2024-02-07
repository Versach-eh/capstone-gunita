import 'package:flutter/material.dart';
import 'package:gunita20/screens/crossword/enter_word.dart';
import 'package:gunita20/screens/crossword/hard_theme.dart';
import 'package:gunita20/screens/crossword/moderate_theme.dart';
import 'package:gunita20/screens/crossword/theme.dart';


class CategoryWordMenuScreen extends StatefulWidget {
  const CategoryWordMenuScreen({Key? key}) : super(key: key);

  @override
  _CategoryWordMenuScreenState createState() => _CategoryWordMenuScreenState();
}

class _CategoryWordMenuScreenState extends State<CategoryWordMenuScreen> {
  void _showDialog() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Color(0xfffcE17612), width: 7.0),
        ),
        backgroundColor: Color(0xfffcFFF9E3),
        title: Text(
          'What do you prefer?',
          style: TextStyle(
            fontFamily: 'purple_smile',
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ThemesMenuScreen(
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(225, 45),
                primary: Color(0xffc36C655),
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
                'Use existing themes',
                style: TextStyle(
                  fontFamily: 'purple_smile',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnterWordScreen(
                            maxAllowedWords: 4,
                            difficulty: 0,
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(225, 45),
                primary: Color(0xffc36C655),
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
                'Create own words',
                style: TextStyle(
                  fontFamily: 'purple_smile',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(225, 45),
                primary: Color(0xffcD63131),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
                shadowColor: Colors.red.shade800.withOpacity(1.0),
                elevation: 5,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'purple_smile',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
void _showDialogM() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Color(0xfffcE17612), width: 7.0),
        ),
        backgroundColor: Color(0xfffcFFF9E3),
        title: Text(
          'What do you prefer?',
          style: TextStyle(
            fontFamily: 'purple_smile',
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ModerateThemesMenuScreen(
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(225, 45),
                primary: Color(0xffc36C655),
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
                'Use existing themes',
                style: TextStyle(
                  fontFamily: 'purple_smile',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnterWordScreen(
                            maxAllowedWords: 5,
                            difficulty: 1,
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(225, 45),
                primary: Color(0xffc36C655),
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
                'Create own words',
                style: TextStyle(
                  fontFamily: 'purple_smile',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(225, 45),
                primary: Color(0xffcD63131),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
                shadowColor: Colors.red.shade800.withOpacity(1.0),
                elevation: 5,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'purple_smile',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
void _showDialogH() {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: BorderSide(color: Color(0xfffcE17612), width: 7.0),
        ),
        backgroundColor: Color(0xfffcFFF9E3),
        title: Text(
          'What do you prefer?',
          style: TextStyle(
            fontFamily: 'purple_smile',
            fontSize: 24.0,
            color: Colors.black,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HardThemesMenuScreen(
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(225, 45),
                primary: Color(0xffc36C655),
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
                'Use existing themes',
                style: TextStyle(
                  fontFamily: 'purple_smile',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EnterWordScreen(
                            maxAllowedWords: 6,
                            difficulty: 2,
                          ),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(225, 45),
                primary: Color(0xffc36C655),
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
                'Create own words',
                style: TextStyle(
                  fontFamily: 'purple_smile',
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Cancel');
              },
              style: ElevatedButton.styleFrom(
                fixedSize: Size(225, 45),
                primary: Color(0xffcD63131),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.white,
                    width: 3.0,
                  ),
                ),
                shadowColor: Colors.red.shade800.withOpacity(1.0),
                elevation: 5,
              ),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'purple_smile',
                  color: Colors.white,
                  fontSize: 16.0,
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
                  // Handle back button press
                  Navigator.pop(context);
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
            // Show dialog when Easy button is pressed
                      _showDialog();
                    },
                    // onPressed: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => EnterWordScreen(
                    //         maxAllowedWords: 4,
                    //         difficulty: 0,
                    //       ),
                    //     ),
                    //   );
                    // },
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
                      "Easy",
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
            // Show dialog when Easy button is pressed
                      _showDialogM();
                    },
                    
                    // onPressed: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => EnterWordScreen(
                    //         maxAllowedWords: 6,
                    //         difficulty: 1,
                    //       ),
                    //     ),
                    //   );
                    // },
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
                      "Medium",
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
            // Show dialog when Easy button is pressed
                      _showDialogH();
                    },
                  // child: ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => EnterWordScreen(
                  //           maxAllowedWords: 8,
                  //           difficulty: 2,
                  //         ),
                  //       ),
                  //     );
                  //   },
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
                      "Hard",
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
