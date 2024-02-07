import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:gunita20/screens/crossword/theme_search.dart';

class PetsScreen extends StatefulWidget {
  const PetsScreen(
      {Key? key, required this.difficulty})
      : super(key: key);

  final int difficulty;

  @override
  _PetsScreenState createState() => _PetsScreenState();
}

class _PetsScreenState extends State<PetsScreen> {
   List<String> selectedWords = [];

void _handleContainerTap(String word) {
    setState(() {
      if (selectedWords.contains(word)) {
        // Deselect the word if it was already selected
        selectedWords.remove(word);
      } else if (selectedWords.length < 4) {
        // Select the word if less than 4 words are selected
        selectedWords.add(word);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/word_wander.png'),
              fit: BoxFit.fill,
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
              SizedBox(height: 20),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Text(
                          'CHOOSE FOUR (4)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26.0,
                            fontFamily: 'kg_inimitable_original',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..color = Colors.black
                              ..strokeWidth = 4,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(1.0),
                                offset: Offset(1, 6),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'CHOOSE FOUR (4)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26.0,
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
                    SizedBox(height: 5.0),
                    Stack(
                      children: [
                        Text(
                          'WORDS BELOW BEFORE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontFamily: 'kg_inimitable_original',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..color = Colors.black
                              ..strokeWidth = 4,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(1.0),
                                offset: Offset(1, 6),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'WORDS BELOW BEFORE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.0,
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
                    SizedBox(height: 5.0),
                    Stack(
                      children: [
                        Text(
                          'STARTING THE GAME:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.0,
                            fontFamily: 'kg_inimitable_original',
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..color = Colors.black
                              ..strokeWidth = 4,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(1.0),
                                offset: Offset(1, 6),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          'STARTING THE GAME:',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28.0,
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
                    SizedBox(height: 20.0),
                    Column(
                children: List.generate(
                  containerTexts.length,
                  (index) => _buildRectangularContainer(
                    width: 300.0,
                    height: 55.0,
                    color: selectedWords.contains(containerTexts[index])
                        ? Colors.blue
                        : Colors.white,
                    borderRadius: 10.0,
                    text: containerTexts[index],
                    onTap: () {
                      // Handle container tap
                      _handleContainerTap(containerTexts[index]);
                    },
                  ),
                ),
              ),

                    SizedBox(height: 30.0),
                    // NEXT BUTTON
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
                          Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ThemeWordSearchScreen(
                                        selectedWords: selectedWords,
                                        difficulty: widget.difficulty,
                                      ),
                                    ),
                                  );// Add functionality if needed
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(280, 70),
                          primary: Color(0xffc36C655),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: Colors.white,
                              width: 3.0,
                            ),
                          ),
                        ),
                        child: Text(
                          "NEXT",
                          style: TextStyle(
                            fontFamily: 'purple_smile',
                            color: Colors.white,
                            fontSize: 28.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  // Function to create a rectangular container
  Widget _buildRectangularContainer({
    required double width,
    required double height,
    required Color color,
    required double borderRadius,
    required String text,
    required VoidCallback onTap, // Added parameter for onTap
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.black,
            width: 3.0,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontSize: 26.0,
            ),
          ),
        ),
      ),
    );
  }

// List of words
List<String> containerTexts = [
  "DOG",
  "CAT",
  "BIRD",
  "FISH",
  "RABBIT",
];