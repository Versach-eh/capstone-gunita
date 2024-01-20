import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditImageDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String albumId;

  const EditImageDetailsScreen({Key? key, required this.imageUrl, required this.albumId}) : super(key: key);

  @override
  _EditImageDetailsScreenState createState() => _EditImageDetailsScreenState();
}

class _EditImageDetailsScreenState extends State<EditImageDetailsScreen> {
  late TextEditingController _titleController;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _noteController = TextEditingController();

    // Fetch initial data and update text controllers
    _fetchImageDetails();
  }

  Future<void> _fetchImageDetails() async {
    try {
      DocumentSnapshot imageSnapshot = await FirebaseFirestore.instance
          .doc('Users/${FirebaseAuth.instance.currentUser!.uid}/albums/${widget.albumId}')
          .get();

      Map<String, dynamic>? imageData = imageSnapshot.data() as Map<String, dynamic>?;

      if (imageData != null) {
        Map<String, dynamic> imageDetails =
            (imageData['imageDetails'] as Map<String, dynamic>?) ?? {};

        setState(() {
          _titleController.text = imageDetails[widget.imageUrl]?['title'] ?? '';
          _noteController.text = imageDetails[widget.imageUrl]?['note'] ?? '';
        });
      }
    } catch (error) {
      print('Error fetching image details: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Image Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: "Note"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add logic to save details to Firebase
                _saveImageDetails();
                Navigator.pop(context); // Close the current screen
              },
              child: Text("Save Details"),
            ),
          ],
        ),
      ),
    );
  }

  void _saveImageDetails() {
    // Add logic to save details to Firebase using widget.albumId and widget.imageUrl
    // For simplicity, let's print the details for now
    print("Title: ${_titleController.text}");
    print("Note: ${_noteController.text}");
    print("Image URL: ${widget.imageUrl}");
    print("Album ID: ${widget.albumId}");

    // Assuming you have an 'imageDetails' field in your data structure
    Map<String, dynamic> imageDetails = {
      'title': _titleController.text,
      'note': _noteController.text,
    };

    // Update Firestore document
    CollectionReference _firestoreReference =
        FirebaseFirestore.instance.collection('Users/${FirebaseAuth.instance.currentUser!.uid}/albums');

    DocumentReference albumDocRef = _firestoreReference.doc(widget.albumId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot albumDocSnapshot = await transaction.get(albumDocRef);

      if (albumDocSnapshot.exists) {
        // Get existing data
        Map<String, dynamic>? albumData = albumDocSnapshot.data() as Map<String, dynamic>?;

        // Get existing image details or initialize an empty map
        Map<String, dynamic> existingImageDetails =
            (albumData?['imageDetails'] as Map<String, dynamic>?) ?? {};

        // Add/update details for the current image URL
        existingImageDetails[widget.imageUrl] = imageDetails;

        // Update the 'imageDetails' field
        transaction.update(albumDocRef, {'imageDetails': existingImageDetails});
      } else {
        // Handle the case where the document doesn't exist
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }
}
