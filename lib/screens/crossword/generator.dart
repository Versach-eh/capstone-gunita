import 'dart:math';

class PuzzleGenerator {
  final List<String> words;
  final int gridSize;

  PuzzleGenerator({
    required this.words,
    required this.gridSize,
  });

  List<List<String>> generatePuzzle() {
    // Create an empty grid
    final grid = List.generate(gridSize, (_) => List<String>.filled(gridSize, ''));

    // Place words randomly on the grid
    final random = Random();
    for (final word in words) {
      final direction = random.nextBool() ? Direction.horizontal : Direction.vertical;
      final x = random.nextInt(gridSize - (direction == Direction.horizontal ? word.length : 0));
      final y = random.nextInt(gridSize - (direction == Direction.vertical ? word.length : 0));

      // Place the word on the grid
      if (canPlaceWord(grid, word, x, y, direction)) {
        placeWord(grid, word, x, y, direction);
      }
    }

    // Fill empty spaces with random letters
    for (var i = 0; i < gridSize; i++) {
      for (var j = 0; j < gridSize; j++) {
        if (grid[i][j].isEmpty) {
          grid[i][j] = String.fromCharCode(random.nextInt(26) + 65); // Random uppercase letter
        }
      }
    }

    return grid;
  }

  bool canPlaceWord(List<List<String>> grid, String word, int x, int y, Direction direction) {
    // Check if the word can be placed in the specified direction without overlapping
    if (direction == Direction.horizontal) {
      if (x + word.length > gridSize) {
        return false;
      }
      for (var i = 0; i < word.length; i++) {
        if (grid[y][x + i].isNotEmpty && grid[y][x + i] != word[i]) {
          return false;
        }
      }
    } else {
      if (y + word.length > gridSize) {
        return false;
      }
      for (var i = 0; i < word.length; i++) {
        if (grid[y + i][x].isNotEmpty && grid[y + i][x] != word[i]) {
          return false;
        }
      }
    }
    return true;
  }

  void placeWord(List<List<String>> grid, String word, int x, int y, Direction direction) {
    // Place the word on the grid in the specified direction
    if (direction == Direction.horizontal) {
      for (var i = 0; i < word.length; i++) {
        grid[y][x + i] = word[i];
      }
    } else {
      for (var i = 0; i < word.length; i++) {
        grid[y + i][x] = word[i];
      }
    }
  }
}

enum Direction { horizontal, vertical }
