import 'package:flutter/material.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({Key? key}) : super(key: key);

  @override
  _InstructionsScreenState createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
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
            // SizedBox(height: 10.0),
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

            // SizedBox(height: 30),
            Center(
              child: Stack(
                children: [
                  Text(
                    'HOW TO PLAY?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 43.0,
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
                    'HOW TO PLAY?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 43.0,
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
            Container(
              width: 350,
              height: 520.0, // Set a fixed height for the container
              margin: EdgeInsets.only(top: 16.0),
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color(0xfffcFFF9E3),
                border: Border.all(
                  color: Color(0xfffcE17612),
                  width: 8.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                  Positioned(
                    top: 10.0, // Adjust the top position as needed
                    left: 10.0, // Adjust the left position as needed
                    child: Text(
                      'Step 1:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40.0, // Adjust the top position as needed
                    left: 10.0, // Adjust the left position as needed
                    child: Text(
                      'Choose difficulty',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Positioned(
                    top: 80.0, // Adjust the top position as needed
                    left: 10.0, // Adjust the left position as needed
                    child: Text(
                      'Step 2:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100.0, // Adjust the top position as needed
                    left: 10.0, // Adjust the left position as needed
                    child: Text(
                      'Select an image to use for the puzzle. Upload a photo or use the default photo.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Positioned(
                    top: 130.0, // Adjust the top position as needed
                    left: 10.0, // Adjust the left position as needed
                    child: Text(
                      'Step 3:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 160.0, // Adjust the top position as needed
                    left: 10.0, // Adjust the left position as needed
                    child: Text(
                      "Press 'Let's start!' to begin.",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Positioned(
                    top: 190.0, // Adjust the top position as needed
                    left: 10.0, // Adjust the left position as needed
                    child: Text(
                      'Step 4:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 220.0, // Adjust the top position as needed
                    left: 10.0, // Adjust the left position as needed
                    child: Text(
                      'Move the puzzle pieces around by dragging until they are all snapped in place.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Positioned(
                    top: 250.0, // Adjust the top position as needed
                    left: 10.0, // Adjust the left position as needed
                    child: Text(
                      'Tip:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),           
                  Positioned(
                    top: 280.0, // Adjust the top position as needed
                    left: 10.0, // Adjust the left position as needed
                    child: Text(
                      'Take a look through all the available pieces below the board and select a familliar one',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  
                  
                   
                ],
              ),
            ),
             )
          ],
        ),
      ),
    );
  }
}