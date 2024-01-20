import 'package:flutter/material.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'dart:math';
import 'dart:async';

class WordSearchPuzzleGenerator {
  final List<String> words;
  final int gridSize;
  final List<List<String>> grid;
  final Random _random = Random();

  WordSearchPuzzleGenerator({
  required this.words,
  required this.grid,
}) : gridSize = 8; // Set gridSize to 8

  List<List<String>> generatePuzzle() {
    // Initialize the grid with random letters
    for (int row = 0; row < gridSize; row++) {
    for (int col = 0; col < 10; col++) {
        grid[row][col] = String.fromCharCode(_random.nextInt(26) + 'A'.codeUnitAt(0));
      }
    }

    // Insert only the entered words into the puzzle
    for (final word in words) {
      bool inserted = false;
      int attempts = 0;

      while (!inserted && attempts < 100) {
        attempts++;

        final direction = _random.nextBool() ? 1 : 0; // 1 for horizontal, 0 for vertical
        final row = _random.nextInt(gridSize);
        final col = _random.nextInt(gridSize);

        if (direction == 1) {
          // Check if the word fits horizontally
          if (col + word.length <= gridSize) {
            inserted = true;
            for (int i = 0; i < word.length; i++) {
              grid[row][col + i] = word[i].toUpperCase();
            }
          }
        } else {
          // Check if the word fits vertically
          if (row + word.length <= gridSize) {
            inserted = true;
            for (int i = 0; i < word.length; i++) {
              grid[row + i][col] = word[i].toUpperCase();
            }
          }
        }
      }
    }

    // Fill remaining empty cells with random letters
    for (int row = 0; row < gridSize; row++) {
      for (int col = 0; col < gridSize; col++) {
        if (grid[row][col].isEmpty) {
          grid[row][col] = String.fromCharCode(_random.nextInt(26) + 'A'.codeUnitAt(0));
        }
      }
    }

    // Check if all words are present, if not, regenerate the puzzle
    if (words.any((word) => !isWordPresent(word))) {
      return generatePuzzle();
    }

    return List<List<String>>.from(grid);
  }

  bool isWordPresent(String word) {
    final flattenedGrid = grid.expand((row) => row).toList();
    final wordUpperCase = word.toUpperCase();

    for (int i = 0; i < flattenedGrid.length - word.length + 1; i++) {
      final currentSlice = flattenedGrid.sublist(i, i + word.length);
      if (currentSlice.join() == wordUpperCase) {
        return true;
      }
    }

    return false;
  }
}


class WordSearchScreen extends StatefulWidget {
  final List<String> enteredWords;

  const WordSearchScreen({Key? key, required this.enteredWords}) : super(key: key);

  @override
  _WordSearchScreenState createState() => _WordSearchScreenState();
}

class _WordSearchScreenState extends State<WordSearchScreen> {
  late List<List<String>> puzzleGrid;
  late List<List<bool>> highlightedCells;
  late List<String> enteredWords;
  late List<String> matchedWords;
  late List<List<bool>> correctCells;
  int secondsElapsed = 0;
  late Timer timer;
  bool isGameStarted = false;
  bool isGamePaused = false;
  String currentWord = '';
  DateTime startTime = DateTime.now();
  Duration get gameTime => DateTime.now().difference(startTime);


 @override
  void initState() {
  super.initState();
  // Initialize the state with the entered words
  enteredWords = widget.enteredWords;
  matchedWords = []; // Initialize matched words list
  initializePuzzle(); // Initialize the puzzle and highlightedCells
}


  void initializePuzzle() {
  final generator = WordSearchPuzzleGenerator(
    words: widget.enteredWords,
    grid: List.generate(8, (index) => List<String>.filled(10, '')),
  );
  puzzleGrid = generator.generatePuzzle();
  highlightedCells = List.generate(8, (index) => List<bool>.filled(10, false));
  correctCells = List.generate(8, (index) => List<bool>.filled(10, false));
}




void onCellTap(int row, int col) {
  if (isGameStarted && !isGamePaused) {
    setState(() {
      if (highlightedCells[row][col]) {
        // If the cell is already highlighted, remove the highlight
        highlightedCells[row][col] = false;
        currentWord = currentWord.substring(0, currentWord.length - 1);
      } else {
        // If the cell is not highlighted, proceed with highlighting
        highlightedCells[row][col] = true;

        final tappedLetter = puzzleGrid[row][col];
        currentWord += tappedLetter;

        // Check if the currentWord matches any entered word
        for (final word in widget.enteredWords) {
          if (currentWord.toLowerCase() == word.toLowerCase()) {
            onWordFound();
            markCorrectCells(); // Update correctCells
            break;
          }
        }
      }
    });
  }
}



  bool isAdjacentCell(int row, int col) {
    // Check if the cell is adjacent to the previously selected cell
    for (int r = 0; r < 6; r++) {
      for (int c = 0; c < 6; c++) {
        if (highlightedCells[r][c] &&
            (row - r).abs() <= 1 &&
            (col - c).abs() <= 1) {
          return true;
        }
      }
    }
    return false;
  }

  bool checkWord() {
    for (final word in widget.enteredWords) {
      if (isWordFound(word)) {
        return true;
      }
    }
    return false;
  }

  bool areAllWordsMatched() {
  return Set.from(widget.enteredWords).difference(Set.from(matchedWords)).isEmpty;
}

  bool isWordFound(String word) {
  final flattenedGrid = puzzleGrid.expand((row) => row).toList();

  final highlightedValues = flattenedGrid
      .asMap()
      .entries
      .where((entry) => highlightedCells[entry.key ~/ 6][entry.key % 6])
      .map((entry) => entry.value)
      .toList();

  print('Word: $word'); // Add this line for debugging
  print('Highlighted values: $highlightedValues'); // Add this line for debugging

  if (highlightedValues.length != word.length) {
    return false;
  }

  for (int i = 0; i < word.length; i++) {
    if (highlightedValues[i].toLowerCase() != word[i].toLowerCase()) {
      return false;
    }
  }

  // Ensure the last letter is correctly tapped
  final lastCell = flattenedGrid.length - 1;
  final lastRow = lastCell ~/ 6;
  final lastCol = lastCell % 6;

  if (highlightedCells[lastRow][lastCol] &&
      flattenedGrid[lastCell].toLowerCase() == word[word.length - 1].toLowerCase()) {
    return true;
  }

  return false;
}


void onWordFound() {
  print('onWordFound called'); // Add this line for debugging

  if (!isGamePaused) {
    setState(() {
      markCorrectCells();
      clearHighlightedCells();
      matchedWords.add(currentWord);
      currentWord = '';

      if (areAllWordsMatched()) {
        stopGame(); // Stop the game when all words are matched
        showCongratulationsDialog(context, gameTime);
}
    });
  }
}

void stopGame() {
    stopTimer();
    isGamePaused = true;
  }

void playAgain() {
  // Add logic to reset the game or navigate to a new game
  setState(() {
    // Reset the game state
    isGameStarted = false;
    isGamePaused = false;
    secondsElapsed = 0;
    enteredWords = widget.enteredWords;
    matchedWords = [];
    currentWord = '';
    initializePuzzle();
  });
}

void showCongratulationsDialog(BuildContext context, Duration gameTime) {
  // Stop the game when all words are matched
  stopGame();

  showDialog( 
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: Color(0xfffcE17612), width: 7.0),
        ),
        backgroundColor: Colors.white, // Change to white
        child: Container(
          width: 300.0, // Adjusted width
          padding: EdgeInsets.symmetric(vertical: 15.0), // Adjusted padding
          decoration: BoxDecoration(
            color: Color(0xfffcFFDE59), // Ribbon background color
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.0),
              topRight: Radius.circular(12.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Congratulations!',
                style: TextStyle(
                  color: Color(0xfffcE17612),
                  fontFamily: 'purple_smile',
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Your score is ${formatDuration(gameTime)}!',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'purple_smile',
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      playAgain();
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 50),
                      primary: Color(0xfffc36C655),
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
                      "Play again",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameLibrary(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(200, 50),
                      primary: Color(0xfffcD63131),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                      shadowColor: Colors.red.shade800.withOpacity(0.8),
                      elevation: 5,
                    ),
                    child: Text(
                      "Quit",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}



  void markCorrectCells() {
  for (int row = 0; row < 2; row++) {
    for (int col = 0; col < 2; col++) {
      if (highlightedCells[row][col]) {
        correctCells[row][col] = true; // Update correctCells
        highlightedCells[row][col] = false;
      }
    }
  }
}

  void clearHighlightedCells() {
    setState(() {
      for (int row = 0; row < 6; row++) {
        for (int col = 0; col < 6; col++) {
          highlightedCells[row][col] = false;
        }
      }
    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void startGame() {
  setState(() {
    isGameStarted = true;
    isGamePaused = false;
    startTime = DateTime.now(); // Set the start time
    startTimer();
  });
}

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      if (!isGamePaused) {
        setState(() {
          secondsElapsed++;
        });
      }
    });
  }

  void pauseGame() {
    setState(() {
      isGamePaused = true;
      stopTimer(); // Stop the timer when the game is paused
      showPauseDialog(context);
    });
  }

  void continueGame() {
    setState(() {
      isGamePaused = false;
      startTimer(); // Resume the timer when the game continues
      Navigator.of(context).pop(); // Close the dialog
    });
  }

  void stopTimer() {
    timer.cancel();
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }

void quitGame() {
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
            'Are you sure you want to quit? You might not want to lose your progress.',
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
              // Text(
              //   'Are you sure you want to quit? You might not want to lose your progress.',
              //   style: TextStyle(
              //     fontSize: 22.0,
              //     fontFamily: 'purple_smile',
              //     color: Colors.black,
              //   ),
              // ),
              SizedBox(height: 5),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the quit confirmation dialog
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
                      'No',
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
                      Navigator.of(context).pop(); // Close the quit confirmation dialog
                      Navigator.of(context).pop(); // Close the pause dialog
                      Navigator.of(context).pop(); // Close the WordSearchScreen
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => GameLibrary())); // Navigate to the GameLibraryScreen
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(225, 45),
                      primary: Color(0xfffcD63131),
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
                      'Yes',
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
     
  void showPauseDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Color(0xfffcE17612), width: .0),
          ),
          backgroundColor: Color(0xfffcFFF9E3),
          title: Text(
            'GAME PAUSED',
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
                'The game is paused. Would you like to...',
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: 'Magdelin',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  ElevatedButton(
                  onPressed: continueGame, // Connect continueGame function to the Continue button
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
                      'Continue',
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isGamePaused = false; // Set the game as not paused
                      });
                      Navigator.of(context).pop(); // Close the dialog
                      // Implement logic for restarting the game
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
                      'Restart',
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                 ElevatedButton(
                    onPressed: () {
                      quitGame(); // Display quit confirmation dialog
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(230, 50),
                      primary: Color(0xfffcD63131),
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
                      'Quit',
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
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
        child: Stack(
          children: [
            Positioned(
              top: 40, // Adjust this value to set the top position
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xfffcFFF9E3),
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'Time: ${formatDuration(Duration(seconds: secondsElapsed))}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                        ),
                        itemCount: 8 * 10,
                        itemBuilder: (context, index) {
                          final row = index ~/ 10;
                          final col = index % 10;

                          final cellSize = MediaQuery.of(context).size.width / 10;

                          return GestureDetector(
                            onTap: () => onCellTap(row, col),
                            child: Container(
                              width: cellSize,
                              height: cellSize,
                              decoration: BoxDecoration(
                                color: highlightedCells[row][col] ? Colors.green : Color(0xfffcFFDE59),
                                border: Border.all(
                                  color: Color(0xfffcE17612),
                                  width: 4.0,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  puzzleGrid[row][col],
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 105,
              left: 15,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.volume_up,
                    size: 35,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      // Handle refresh icon tap
                      // You can add logic to reset the puzzle or shuffle the letters
                    },
                    child: Icon(
                      Icons.refresh,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: pauseGame,
                    child: Icon(
                      Icons.pause,
                      size: 35,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: 110,
                left: 15,
                right: 15,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0xfffcFFF9E3),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Words:',
                          style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (String word in widget.enteredWords)
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: matchedWords.contains(word) ? Colors.green : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  word,
                                  style: TextStyle(
                                    fontFamily: 'kg_inimitable_original',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 45.0,
                left: MediaQuery.of(context).size.width / 2 - 140.0,
                child: !isGameStarted
                    ? Container(
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
                          onPressed: startGame,
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(280, 60),
                            primary: const Color(0xfffc36C655),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 3.0,
                              ),
                            ),
                          ),
                          child: Text(
                            "Let's Start!",
                            style: TextStyle(
                              fontFamily: 'purple_smile',
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}