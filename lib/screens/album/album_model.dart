class MyAlbum {
  String id;
  String title;
  List <String> imageUrls;
  // List <String> imageTexts;

  MyAlbum({
    required this.id,
    required this.title,
    required this.imageUrls,
    // required this.imageTexts
    });

    // Add a factory method to convert a map into a MyAlbum object
  factory MyAlbum.fromMap(Map<String, dynamic> map) {
    return MyAlbum(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }
}

