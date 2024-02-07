import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/screens/album/edit_image_details_screen.dart';
import 'package:gunita20/screens/album/image_screen.dart';

class ImageDetailScreen extends StatelessWidget {
  final String imageUrl;
  final String albumId; // Add the album ID to identify the specific image
  final String title;
  final String note;
  final User? currentUser;
    final MyAlbum album;

  const ImageDetailScreen({
    Key? key,
    required this.imageUrl,
    required this.albumId,
    required this.title,
    required this.note, this.currentUser, required this.album,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(       // copy this for purple back buttons
  title: Text(""),
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Color.fromRGBO(69, 48, 178, 1)),
  leading: Container(
    // padding: EdgeInsets.all(8),
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromRGBO(69, 48, 178, 1),
    ),
    child: Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right:19.0),
          child: IconButton(
              icon: Icon(Icons.arrow_back,
              color: Colors.white,),
              onPressed: () {
                // Show a confirmation dialog before deleting
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ImageDisplayScreen(albumId: albumId, album: album,)),
              );
              },
          ),
        ),
      ],
    ),
  
),
        
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(8.0,5,8,8),
            
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromRGBO(69, 48, 178, 1),
    ),
            child: IconButton(
              icon: Icon(Icons.delete_outline),
              onPressed: () {
                                _showDeleteConfirmationDialog(context);

                
              },
              color: Colors.white, // Set the color to red
                iconSize: 30.0, // Set the size of the icon
                splashRadius: 25.0, // Set the splash radius for a larger touch area
                
            ),
          ),
        ],
      ),
      body: Container(
  margin: EdgeInsets.only(bottom: 16.0),
  child: Stack(
    children: [
      Center(
        child: Hero(
          tag: imageUrl,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
      // adjust the position of the floating button
      Positioned(
        bottom: 2.0, // Adjust the position from the bottom
        right:170.0, // Adjust the position from the right
        child: FloatingActionButton(
          onPressed: () {
            // Show the bottom sheet for editing details
            _showEditDetailsBottomSheet(context);
          },
          backgroundColor: Color.fromRGBO(70, 48, 178, 0.486), // Set the color here
        foregroundColor: Colors.white,
        child: Icon(Icons.keyboard_arrow_up_sharp,),
        shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(100.0), // Adjust the value as needed
          ),
        ),
      ),
    ],
  ),
),);
  }

  void _showEditDetailsBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: EditImageDetailsScreen(
            imageUrl: imageUrl,
            albumId: albumId,
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Image"),
          content: Text("Are you sure you want to delete this image?"),
          actions: [
            TextButton(
              onPressed: () {
                // Dismiss the dialog
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                // Delete the image and dismiss the dialog
                _deleteImageFromFirestore(context);
                Navigator.pop(context);
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void _deleteImageFromFirestore(BuildContext context) async {
    try {
      // Get a reference to the Firestore document for the album
      DocumentReference albumDocRef =
          FirebaseFirestore.instance.collection('Users/${FirebaseAuth.instance.currentUser!.uid}/albums').doc(albumId);

      // Use a transaction to ensure consistency
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Get the current data of the album
        DocumentSnapshot albumDocSnapshot = await transaction.get(albumDocRef);

        if (albumDocSnapshot.exists) {
          // If the album exists, update the 'imageUrls' field
          List<String> existingImageUrls = List<String>.from(albumDocSnapshot['imageUrls'] ?? []);

          // Remove the current image URL from the list
          existingImageUrls.remove(imageUrl);

          // Update the 'imageUrls' field in Firestore
          transaction.update(albumDocRef, {'imageUrls': existingImageUrls});
        }
         Navigator.pop(context);
      });

      // After successfully deleting, you might want to navigate back or perform any other actions
     
    } catch (e) {
      print("Error deleting image: $e");
      // Handle the error as needed
    }
  }
}
