import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/screens/album/video_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class UploadVideoScreen extends StatefulWidget {
  final MyAlbum album;

  const UploadVideoScreen({super.key, required this.album});

  @override
  _UploadVideoScreenState createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  final ImagePicker _imagePicker = ImagePicker();

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
                    "to upload a video.",
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
                        onPressed: () async {
                          await _uploadVideoToFirebase();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  VideoDisplayScreen(albumId: widget.album.id, album: widget.album,),
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
                          "Add video",
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
                    size: 35,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _uploadVideoToFirebase() async {
  final user = FirebaseAuth.instance.currentUser!;
  final pickedFile = await _imagePicker.pickVideo(source: ImageSource.gallery);

  if (pickedFile != null) {
    final thumbnail = await _generateThumbnail(pickedFile.path);

    final videoRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${user.uid}/albums/${widget.album.id}/videos/${pickedFile.path.split('/').last}');

    final thumbnailRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${user.uid}/albums/${widget.album.id}/thumbnails/${pickedFile.path.split('/').last}.jpg');

    final uploadVideoTask = videoRef.putFile(
      File(pickedFile.path),
      firebase_storage.SettableMetadata(contentType: 'video/mp4'),
    );

    final uploadThumbnailTask = thumbnailRef.putData(thumbnail);

    // Use separate await statements for clarity
    await uploadVideoTask;
    await uploadThumbnailTask;

    final videoDownloadUrl = await videoRef.getDownloadURL();
    final thumbnailDownloadUrl = await thumbnailRef.getDownloadURL();

    // Update Firestore document
    CollectionReference _firestoreReference =
        FirebaseFirestore.instance.collection('Users/${user.uid}/albums');

    DocumentReference albumDocRef = _firestoreReference.doc(widget.album.id);
    CollectionReference videosCollectionRef = albumDocRef.collection('videos');
    DocumentReference videoDocRef = videosCollectionRef.doc();

    // Use a transaction to handle the case where the document might not exist
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(videoDocRef, {
        'videoUrl': videoDownloadUrl,
        'thumbnailUrl': thumbnailDownloadUrl,
        'title': 'Video Title', // You can set this dynamically based on user input
        'description': 'Video Description', // You can set this dynamically based on user input
      });
    });
  }
}



  Future<Uint8List> _generateThumbnail(String videoPath) async {
    final uint8List = await VideoThumbnail.thumbnailData(
      video: videoPath,
      imageFormat: ImageFormat.JPEG,
      quality: 100,
    );
    return uint8List!;
  }
}
