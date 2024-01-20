// solely for uploading images

// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_images_screen.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/screens/album/image_screen.dart';
import 'package:gunita20/services/firebase_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:gunita20/screens/loading.dart';
import 'package:path/path.dart';


import 'image_model.dart';

class UploadImagesScreen extends StatefulWidget {
  final User? currentUser;
  final MyAlbum album;
  
  
  const UploadImagesScreen({super.key, required this.currentUser, required this.album});

  @override
  // State<UploadImagesScreen> createState() => _UploadImagesScreenState();
    _UploadImagesScreenState createState() => _UploadImagesScreenState();


}

class _UploadImagesScreenState extends State<UploadImagesScreen> {

  final ImagePicker _imagePicker = ImagePicker();
  List<String> _imageUrls = [];
  List<String> _imageTexts = [];
  List<ImageModel> images = [];

  final FirebaseService firebaseService = FirebaseService();
  List<MyAlbum> albums = [];



  @override
  void initState() {
    super.initState();
    _imageUrls = widget.album.imageUrls;
    // _imageTexts = List<String>.filled(_imageUrls.length, ''); // Initialize empty text for each image
    _imageTexts = [];
    _loadAlbums(); // yet to be reviewed

  }

    Future<void> _loadAlbums() async { 
    final List<MyAlbum> loadedAlbums = await firebaseService.getAlbums();
    setState(() {
      albums = loadedAlbums;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 60,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Tap the button below",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Magdelin',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "to upload a photo.",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Magdelin',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 35),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Your new logic here, if needed
                          _uploadImageToFirebase();

                          // navigates back to album after selecting and uploading image
                          Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageDisplayScreen(albumId: widget.album.id, album: widget.album,), // current user might now work
                        ),
                      );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(220, 200),
                          primary: Color.fromARGB(221, 224, 224, 224).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          "Add photo",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            left: 16,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 35, // adjust the size of the icon
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Color(0xff4f22cd),
      //   onPressed: () {
      //     // Your new logic here, if needed
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }


// new pasted from working screen images
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

  if (!albumDocSnapshot.exists) {
          // Initialize title and note with dummy values
          transaction.set(albumDocRef, {
            'imageUrls': [downloadUrl],
            'title': 'Image Title',
            'note': 'Your Note',
          });
        } else {
          List<String> existingImageUrls = List<String>.from(albumDocSnapshot['imageUrls'] ?? []);
          existingImageUrls.add(downloadUrl);

          // Update the 'imageUrls' field
          transaction.update(albumDocRef, {'imageUrls': existingImageUrls});
        }
});

      });
    }
  }
}