import 'package:flutter/material.dart';
import 'package:gunita20/screens/crossword/word_search.dart';
import 'package:flutter/services.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase() ?? '',
      selection: newValue.selection,
    );
  }
}

class EnterWordScreen extends StatefulWidget {
  const EnterWordScreen(
      {Key? key, required this.maxAllowedWords, required this.difficulty})
      : super(key: key);

  final int maxAllowedWords;
  final int difficulty;

  @override
  _EnterWordScreenState createState() => _EnterWordScreenState();
}

class _EnterWordScreenState extends State<EnterWordScreen> {
  TextEditingController _wordController = TextEditingController();
  List<String> enteredWords = [];
  bool isWordLimitReached() {
    return enteredWords.length >= widget.maxAllowedWords;
  }

  void _showLimitReachedDialog() {
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
            'LIMIT REACHED',
            style: TextStyle(
              fontFamily: 'kg_inimitable_original',
              fontSize: 28.0,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "You have reached the limit of ${widget.maxAllowedWords} words.",
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Magdelin',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
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
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(230, 50),
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
                    "Okay",
                    style: TextStyle(
                      fontFamily: 'purple_smile',
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDuplicateWordDialog() {
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
            'DUPLICATE WORD',
            style: TextStyle(
              fontFamily: 'kg_inimitable_original',
              fontSize: 28.0,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "Please enter a different word.",
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Magdelin',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
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
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(230, 50),
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
                    "Okay",
                    style: TextStyle(
                      fontFamily: 'purple_smile',
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showWordLimitDialog() {
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
            'WORD LIMIT NOT REACHED',
            style: TextStyle(
              fontFamily: 'kg_inimitable_original',
              fontSize: 28.0,
              color: Colors.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "You haven't entered ${widget.maxAllowedWords} words yet.",
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Magdelin',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(10, 46, 125, 50)
                          .withOpacity(1.0),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 6),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Dismiss the dialog
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(230, 50),
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
                    "Okay",
                    style: TextStyle(
                      fontFamily: 'purple_smile',
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
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
                          'TYPE ANY WORD IN',
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
                          'TYPE ANY WORD IN',
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
                          'THE SPACE BELOW.',
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
                          'THE SPACE BELOW.',
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
                    SizedBox(height: 25.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextFormField(
                        controller: _wordController,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(
                              r'[^a-zA-Z]')), // Allow only alphabetic characters
                          LengthLimitingTextInputFormatter(
                              10), // Limit the length to 10 characters
                          UpperCaseTextFormatter(), // Convert input to uppercase
                        ],
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 3.0,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (enteredWords.length <
                                    widget.maxAllowedWords) {
                                  String newWord = _wordController.text;
                                  if (!enteredWords.contains(newWord)) {
                                    enteredWords.add(newWord);
                                    _wordController.clear();
                                  } else {
                                    _showDuplicateWordDialog();
                                  }
                                } else {
                                  _showLimitReachedDialog();
                                }
                              });
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.black,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Stack(
                      children: [
                        Text(
                          'YOUR WORDS:',
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
                          'YOUR WORDS:',
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
                    SizedBox(height: 10.0),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight: 20,
                                maxHeight:
                                    MediaQuery.of(context).size.height / 2.5),
                            child: ListView.builder(
                              itemCount: enteredWords.length,
                              itemBuilder: (BuildContext context, int index) {
                                String word = enteredWords[index];

                                return Container(
                                  width: 300.0,
                                  height: 60.0,
                                  margin: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors.black,
                                      width: 3.0,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            word,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily:
                                                  'kg_inimitable_original',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            setState(() {
                                              enteredWords.remove(word);
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
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
                              if (isWordLimitReached()) {
                                // Proceed to the next screen only if 4 words have been entered
                                if (enteredWords.toSet().length ==
                                    enteredWords.length) {
                                  // No repeated words, navigate to the next screen
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => WordSearchScreen(
                                        enteredWords: enteredWords,
                                        difficulty: widget.difficulty,
                                      ),
                                    ),
                                  );
                                } else {
                                  // Show a notification for repeated words
                                  _showDuplicateWordDialog();
                                }
                              } else {
                                // Show a notification that 4 words haven't been entered
                                _showWordLimitDialog();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(300, 50),
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
