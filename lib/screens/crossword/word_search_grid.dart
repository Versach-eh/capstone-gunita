// import 'package:flutter/material.dart';

// class WordSearchGrid extends StatefulWidget {
//   @override
//   _WordSearchGridState createState() => _WordSearchGridState();
// }

// class _WordSearchGridState extends State<WordSearchGrid> {
//   List<String> words = [];
//   List<List<String>> grid = [];
//   List<List<bool>> isSelected = [];

//   TextEditingController wordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             controller: wordController,
//             decoration: InputDecoration(
//               labelText: 'Enter a word to find',
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: _addWord,
//           child: Text('Add Word'),
//         ),
//         Expanded(
//           child: GridView.builder(
//             shrinkWrap: true,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 7,
//             ),
//             itemCount: grid.length * grid.length,
//             itemBuilder: (context, index) {
//               final row = index ~/ grid.length;
//               final col = index % grid.length;
//               return InkWell(
//                 onTap: () {
//                   setState(() {
//                     isSelected[row][col] = !isSelected[row][col];
//                   });
//                   _checkWords();
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     color:
//                         isSelected[row][col] ? Colors.yellow : Colors.white,
//                   ),
//                   child: Center(
//                     child: Text(
//                       grid[row][col],
//                       style: TextStyle(fontSize: 20),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         SizedBox(height: 20),
//         ElevatedButton(
//           onPressed: _resetGame,
//           child: Text('Reset Game'),
//         ),
//       ],
//     );
//   }

//   void _addWord() {
//     String newWord = wordController.text.toUpperCase();
//     if (newWord.isNotEmpty && !words.contains(newWord)) {
//       setState(() {
//         words.add(newWord);
//         wordController.clear();
//         _generateGrid();
//       });
//     }
//   }

//   void _generateGrid() {
//     // Implement your logic to generate a new word search grid here
//     // For simplicity, using a hardcoded 7x7 grid
//     grid = [
//       ['F', 'L', 'U', 'T', 'T', 'E', 'R'],
//       ['A', 'D', 'A', 'R', 'T', 'D', 'E'],
//       ['W', 'I', 'D', 'G', 'E', 'T', 'S'],
//       ['L', 'E', 'M', 'O', 'B', 'I', 'L'],
//       ['C', 'K', 'R', 'J', 'P', 'Q', 'X'],
//       ['Y', 'Z', 'A', 'H', 'N', 'U', 'K'],
//       ['V', 'W', 'C', 'S', 'Y', 'D', 'B'],
//     ];

//     isSelected = List.generate(
//       grid.length,
//       (i) => List.generate(grid.length, (j) => false),
//     );
//   }

//   void _checkWords() {
//     for (String word in words) {
//       bool found = true;
//       for (int i = 0; i < word.length; i++) {
//         if (!isSelected[i][i]) {
//           found = false;
//           break;
//         }
//       }
//       if (found) {
//         _showSnackBar('Word found: $word');
//       }
//     }
//   }

//   void _resetGame() {
//     setState(() {
//       words.clear();
//       wordController.clear();
//       _generateGrid();
//       for (int i = 0; i < isSelected.length; i++) {
//         for (int j = 0; j < isSelected[i].length; j++) {
//           isSelected[i][j] = false;
//         }
//       }
//     });
//   }

//   void _showSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
// }
