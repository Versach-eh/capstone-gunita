class Difficulty {
  String id;
  List <int> scoresTimerValues;

  Difficulty({
    required this.id,
    required this.scoresTimerValues,
    });

    // Add a factory method to convert a map into a Difficulty object
  factory Difficulty.fromMap(Map<String, dynamic> map) {
    return Difficulty(
      id: map['id'] ?? '',
      scoresTimerValues: List<int>.from(map['scoresTimerValues'] ?? []),
    );
  }
}