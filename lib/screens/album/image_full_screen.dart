import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/edit_image_details_screen.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String albumId; // Add the album ID to identify the specific image
  final String title;
  final String note;

  const ImageDetailScreen({Key? key, required this.imageUrl, required this.albumId, required this.title, required this.note}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Details"),
      ),
      body: Center(
        child: Hero(
          tag: imageUrl, // Use the image URL as the Hero tag
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the screen where you can edit image details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditImageDetailsScreen(imageUrl: imageUrl, albumId: albumId),
            ),
          );
        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
