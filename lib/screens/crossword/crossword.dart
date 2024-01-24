// import 'package:flutter/material.dart';
// import 'dart:math';
// import 'package:flutter/services.dart';

// class WordSearchPuzzleGenerator {
//   final List<String> words;
//   final int gridSize;
//   final List<List<String>> grid;
//   final Random _random = Random();

//   WordSearchPuzzleGenerator({
//     required this.words,
//     required this.gridSize,
//     required this.grid,
//   });

//   List<List<String>> generatePuzzle() {
//     // Fill the grid with random letters as a placeholder for now
//     for (int row = 0; row < gridSize; row++) {
//       for (int col = 0; col < gridSize; col++) {
//         grid[row][col] = String.fromCharCode(_random.nextInt(26) + 'A'.codeUnitAt(0));
//       }
//     }

//     // Insert words into the puzzle
//     for (final word in words) {
//       bool inserted = false;
//       while (!inserted) {
//         final direction = _random.nextBool() ? 1 : 0; // 1 for horizontal, 0 for vertical
//         final row = _random.nextInt(gridSize);
//         final col = _random.nextInt(gridSize);
//         final wordFits = direction == 1
//             ? col + word.length <= gridSize
//             : row + word.length <= gridSize;

//         if (wordFits) {
//           inserted = true;
//           for (int i = 0; i < word.length; i++) {
//             if (direction == 1) {
//               grid[row][col + i] = word[i];
//             } else {
//               grid[row + i][col] = word[i];
//             }
//           }
//         }
//       }
//     }

//     return grid;
//   }
// }

// void main() {
//   runApp(CrosswordApp());
// }

// class CrosswordApp extends StatefulWidget {
//   @override
//   _CrosswordAppState createState() => _CrosswordAppState();
// }

// class _CrosswordAppState extends State<CrosswordApp> {
//   final List<String> words = [];
//   final TextEditingController _wordController = TextEditingController();
//   List<List<String>> _puzzleGrid = [];
//   late final WordSearchPuzzleGenerator _puzzleGenerator;

//   @override
//   void initState() {
//     super.initState();
//     _puzzleGenerator = WordSearchPuzzleGenerator(
//       words: words,
//       gridSize: 8,
//       grid: List.generate(8, (_) => List<String>.filled(8, '')),
//     );
//   }

//   void addWord(String word) {
//     setState(() {
//       words.add(word);
//     });
//   }

//   void resetGame() {
//     setState(() {
//       words.clear();
//       _puzzleGrid = List.generate(8, (_) => List<String>.filled(8, ''));
//       _wordController.clear();
//     });
//   }

//   bool canAddWord() {
//     return words.length < 4; // Limit to 4 words
//   }

//   bool shouldShowResetButton() {
//     return words.isNotEmpty; // Show reset button if words are added
//   }

//   bool shouldShowGenerateButton() {
//     return words.isNotEmpty || _puzzleGrid.isNotEmpty; // Show generate button if words are added or puzzle is generated
//   }

//   void _generatePuzzle() {
//   if (words.length == 4) {
//     _puzzleGrid = _puzzleGenerator.generatePuzzle();

//     // Ensure all words are in the puzzle
//     for (final word in words) {
//       if (!_puzzleGrid.toString().contains(word)) {
//         _puzzleGrid = _puzzleGenerator.generatePuzzle();
//       }
//     }

//     // Print the generated grid to the console
//     for (final row in _puzzleGrid) {
//       print(row.join(" "));
//     }

//     setState(() {});
//   }
// }



//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Crossword Puzzle Game',
//       theme: ThemeData(
//         primaryColor: Colors.red,
//         scaffoldBackgroundColor: Color(0xffD9CCFF),
//       ),
//       home: CrosswordScreen(
//         words: words,
//         onAddWord: addWord,
//         onResetGame: resetGame,
//         canAddWord: canAddWord(),
//         shouldShowResetButton: shouldShowResetButton(),
//         shouldShowGenerateButton: shouldShowGenerateButton(),
//         puzzleGrid: _puzzleGrid,
//         generatePuzzle: _generatePuzzle,
//       ),
//     );
//   }
// }

// class CrosswordScreen extends StatefulWidget {
//   final List<String> words;
//   final Function(String) onAddWord;
//   final VoidCallback onResetGame;
//   final bool canAddWord;
//   final bool shouldShowResetButton;
//   final bool shouldShowGenerateButton;
//   final List<List<String>> puzzleGrid;
//   final Function generatePuzzle;

//   CrosswordScreen({
//     Key? key,
//     required this.words,
//     required this.onAddWord,
//     required this.onResetGame,
//     required this.canAddWord,
//     required this.shouldShowResetButton,
//     required this.shouldShowGenerateButton,
//     required this.puzzleGrid,
//     required this.generatePuzzle,
//   }) : super(key: key);

//   @override
//   _CrosswordScreenState createState() => _CrosswordScreenState();
// }

// class _CrosswordScreenState extends State<CrosswordScreen> {
//   final TextEditingController _wordController = TextEditingController();
//   List<List<bool>> _highlightedCells = List.generate(8, (_) => List<bool>.filled(8, false));
//   String _currentWord = '';
//   List<String> _foundWords = [];

//   bool _isWordFound(String word) {
//     return _foundWords.contains(word);
//   }

//   void _addWord() {
//     final word = _wordController.text.trim();

//     if (word.isEmpty) {
//       return; // Don't add empty words
//     }

//     setState(() {
//       if (!widget.words.contains(word)) {
//         widget.onAddWord(word);
//       } else {
//         // Show a dialog if the word is already added
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text('Duplicate Word'),
//               content: Text('The word "$word" is already added. Please enter a different word.'),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text('OK'),
//                   onPressed: () {
//                     Navigator.of(context).pop(); // Close the dialog
//                   },
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     });

//     _wordController.clear();
//   }

//   void _handleWordFound(String word) {
//     setState(() {
//       _foundWords.add(word);
//       if (_foundWords.length == widget.words.length) {
//         _showCongratulationsDialog();
//       }
//     });
//   }

//   void _showCongratulationsDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Congratulations!'),
//           content: Text('Wow, you did great!'),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Play Again'),
//               onPressed: () {
//                 widget.onResetGame();
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'CROSSWORD PUZZLE',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(height: 20),

//             Container(
//   color: Color(0xff4530B2),
//   padding: const EdgeInsets.all(8.0),
//   child: Column(
//     children: [
//       Container(
//         padding: const EdgeInsets.only(bottom: 8.0),
//         child: Text(
//           'Enter a word',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//           ),
//         ),
//       ),
//       Container(
//         height: 60,
//         child: TextField(
//           controller: _wordController,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//           ),
//           decoration: InputDecoration(
//             hintText: 'Type your word here',
//             hintStyle: TextStyle(
//               color: Colors.white.withOpacity(0.5),
//               fontSize: 18,
//             ),
//             border: InputBorder.none,
//             focusedBorder: UnderlineInputBorder( // Add underline when focused
//               borderSide: BorderSide(color: Colors.white),
//             ),
//           ),
//           inputFormatters: [
//             FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z]+$')), // Allow only letters
//           ],
//           textCapitalization: TextCapitalization.characters, // Set text to uppercase
//         ),
//       ),
//       SizedBox(height: 8),
//       ElevatedButtonContainer(
//         onPressed: widget.canAddWord ? _addWord : widget.onResetGame,
//         buttonText: widget.canAddWord ? 'Add Word' : 'Reset Game',
//       ),
//     ],
//   ),
//           ),
//             SizedBox(height: 16),

//             Column(
//               children: widget.words.map((word) {
//                 final isWordFound = _isWordFound(word);
//                 final textColor = isWordFound ? Colors.green : Colors.white;
//                 return CreativeWordContainer(word, textColor: textColor);
//               }).toList(),
//             ),

//             SizedBox(height: 16),

//             if (widget.shouldShowGenerateButton)
//               ElevatedButtonContainer(
//                 onPressed: widget.shouldShowGenerateButton ? () => widget.generatePuzzle() : null,
//                 buttonText: widget.puzzleGrid.isNotEmpty ? 'Generate Crossword' : 'Generate Crossword',
//               ),

//             SizedBox(height: 20),

//             if (widget.puzzleGrid.isNotEmpty)
//               Container( // Wrap the PuzzleGrid with Container
//                 margin: EdgeInsets.symmetric(horizontal: 20), // Add space on both sides
//                 child: PuzzleGrid(
//                   puzzleGrid: widget.puzzleGrid,
//                   highlightedCells: _highlightedCells,
//                   onWordFound: _handleWordFound,
//                 ),
//               ),

//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ElevatedButtonContainer extends StatelessWidget {
//   final void Function()? onPressed;
//   final String buttonText;

//   ElevatedButtonContainer({
//     required this.onPressed,
//     required this.buttonText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50), // Adjust padding for the container
//       child: ElevatedButton(
//         onPressed: onPressed,
//         child: Text(
//           buttonText,
//           style: TextStyle(
//             fontSize: 20,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CreativeWordContainer extends StatelessWidget {
//   final String word;
//   final Color textColor;

//   CreativeWordContainer(this.word, {required this.textColor});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 4),
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Center(
//         child: Text(
//           word,
//           style: TextStyle(
//             color: textColor,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PuzzleGrid extends StatelessWidget {
//   final List<List<String>> puzzleGrid;
//   final List<List<bool>> highlightedCells;
//   final Function(String) onWordFound;

//   PuzzleGrid({
//     required this.puzzleGrid,
//     required this.highlightedCells,
//     required this.onWordFound,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: puzzleGrid.length,
//       ),
//       itemCount: puzzleGrid.length * puzzleGrid[0].length,
//       itemBuilder: (context, index) {
//         final row = index ~/ puzzleGrid.length;
//         final col = index % puzzleGrid.length;
//         final cellValue = puzzleGrid[row][col];
//         final isHighlighted = highlightedCells[row][col];

//         return GestureDetector(
//           onTap: () {
//             if (isHighlighted) {
//               onWordFound(cellValue);
//             }
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black),
//               color: isHighlighted ? Colors.green : Colors.purple,
//             ),
//             child: Center(
//               child: Text(
//                 cellValue,
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
