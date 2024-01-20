// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/screens/album/image_full_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class ImageDisplayScreen extends StatefulWidget {
  final String albumId;
    final User? currentUser;
      final MyAlbum album;



  const ImageDisplayScreen({Key? key, required this.albumId, this.currentUser, required this.album}) : super(key: key);

  @override
  _ImageDisplayScreenState createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
    final ImagePicker _imagePicker = ImagePicker();

  late Stream<List<String>> _imageStream;
  late Future<String> _albumTitleFuture;

  @override
  void initState() {
    super.initState();
    _imageStream = _getImagesStream();
    _albumTitleFuture = _getAlbumTitle();
  }

  Stream<List<String>> _getImagesStream() {
    return FirebaseFirestore.instance
        .doc('Users/${FirebaseAuth.instance.currentUser!.uid}/albums/${widget.albumId}')
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      // Use the map function to extract the 'imageUrls' field from the snapshot
      List<String> imageUrls = (snapshot.get('imageUrls') as List<dynamic>? ?? []).cast<String>();
      return imageUrls;
    });
  }

  Future<String> _getAlbumTitle() async {
    DocumentSnapshot albumSnapshot = await FirebaseFirestore.instance
        .doc('Users/${FirebaseAuth.instance.currentUser!.uid}/albums/${widget.albumId}')
        .get();

    return albumSnapshot.get('title') as String? ?? 'Untitled Album';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<String>(
          future: _albumTitleFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              String albumTitle = snapshot.data ?? "Untitled Album";
              return Text("Memories from $albumTitle");
            }
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0), // Adjust the height of the line
          child: Divider(
            color: Colors.grey, // Adjust the color of the line
            height: 0.0, // Adjust the height of the line
          ),
        ),
      ),
      
      body: StreamBuilder<List<String>>(
        stream: _imageStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            List<String> imageUrls = snapshot.data ?? [];
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                
    return GestureDetector(
      onTap: () {
        // Navigate to a new screen to view the image in larger scale
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ImageDetailScreen(imageUrl: imageUrls[index], albumId: widget.albumId, title: '', note: '',),
          ),
        );
      },
      child: Card(
        // Your existing Card widget code here
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          child: Image.network(imageUrls[index], fit: BoxFit.cover),
        ),
                      ),
                    );
                  },

            );
          }
        },
      ),
      // Stack widget for the "Add more memories" button
floatingActionButton: Positioned(
        bottom: 16.0,
        right: 16.0,
        child: ElevatedButton(
          onPressed: () {
            _uploadImageToFirebase();
          },
          child: Text("Add more memories"),
            ),
          ),
    );
  }
  Future<void> _uploadImageToFirebase() async {
    final user = FirebaseAuth.instance.currentUser!;
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Users/${widget.currentUser?.uid}/albums/${widget.album.id}/${pickedFile.path.split('/').last}');

      final uploadTask = ref.putFile(
        File(pickedFile.path),
        firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
      );

      await uploadTask.whenComplete(() async {
        String downloadUrl = await ref.getDownloadURL();

        // Update Firestore document
        CollectionReference _firestoreReference =
            FirebaseFirestore.instance.collection('Users/${user.uid}/albums');

        DocumentReference albumDocRef = _firestoreReference.doc(widget.album.id);

        // Use a transaction to handle the case where the document might not exist
        await FirebaseFirestore.instance.runTransaction((transaction) async {
  DocumentSnapshot albumDocSnapshot = await transaction.get(albumDocRef);

  if (albumDocSnapshot.exists) {
    List<String> existingImageUrls = List<String>.from(albumDocSnapshot['imageUrls'] ?? []);

    // Add the new image URL
    existingImageUrls.add(downloadUrl);

    // Update the 'imageUrls' field
    transaction.update(albumDocRef, {'imageUrls': existingImageUrls});
  } else {
    // Handle the case where the document doesn't exist
  }
});

      });
    }
  }
  
}
