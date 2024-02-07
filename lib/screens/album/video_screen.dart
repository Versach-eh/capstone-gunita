import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/album/image_screen.dart';
// import 'package:gunita20/screens/album/video_full_screen.dart';
import 'package:gunita20/screens/album/video_model.dart';
import 'package:gunita20/services/firebase_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoDisplayScreen extends StatefulWidget {
  final String albumId;
  final User? currentUser;
  final MyAlbum album;

  const VideoDisplayScreen(
      {Key? key, required this.albumId, this.currentUser, required this.album})
      : super(key: key);

  @override
  _VideoDisplayScreenState createState() => _VideoDisplayScreenState();
}

class _VideoDisplayScreenState extends State<VideoDisplayScreen> {
  final FirebaseService firebaseService = FirebaseService();

  late Stream<List<VideoModel>> _videoStream;
  late Future<String> _albumTitleFuture;
    final ImagePicker _imagePicker = ImagePicker();


  @override
  void initState() {
    super.initState();
    _videoStream = _getVideosStream();
    _albumTitleFuture = _getAlbumTitle();
  }

  Stream<List<VideoModel>> _getVideosStream() {
    return FirebaseFirestore.instance
        .doc('Users/${FirebaseAuth.instance.currentUser!.uid}/albums/${widget.albumId}')
        .collection('videos')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      return snapshot.docs
          .map((DocumentSnapshot doc) => VideoModel.fromDocument(doc))
          .toList();
    });
  }

  Stream<String> _getAlbumTitleStream() {
    return FirebaseFirestore.instance
        .doc('Users/${FirebaseAuth.instance.currentUser!.uid}/albums/${widget.albumId}')
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      return snapshot.get('title') as String? ?? 'Untitled Album';
    });
  }

  Future<String> _getAlbumTitle() async {
    DocumentSnapshot albumSnapshot = await FirebaseFirestore.instance
        .doc('Users/${FirebaseAuth.instance.currentUser!.uid}/albums/${widget.albumId}')
        .get();

    return albumSnapshot.get('title') as String? ?? 'Untitled Album';
  }

Future<void> _deleteAlbum() async {
  // Access the current user directly
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Store album information before deleting
  String albumId = widget.album.id;
  String albumTitle = widget.album.title;

  // Show a confirmation dialog
  bool confirmDelete = await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Confirm Delete'),
      content: Text('Are you sure you want to delete the "$albumTitle" album?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text('Delete'),
        ),
      ],
    ),
  );

  // If the user confirms the delete, proceed with deletion
  if (confirmDelete == true) {
    // Delete the album from Firestore
    CollectionReference _firestoreReference =
        FirebaseFirestore.instance.collection('Users/${currentUser?.uid}/albums');

    DocumentReference albumDocRef = _firestoreReference.doc(albumId);

    // Check if the album document exists before attempting to delete
    if ((await albumDocRef.get()).exists) {
      await albumDocRef.delete();
    }

    // Delete the associated images from Firebase Storage
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('Users/${currentUser?.uid}/albums/$albumId/')
          .delete();
    } catch (e) {
      // Handle any errors during image deletion
      print('Error deleting images: $e');
    }

    // Navigate back to the previous screen or perform any other actions
    Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Album(), // current user might now work
            ),
          );
  }
}

Future<String?> _showRenameDialog(BuildContext context) async {
  TextEditingController _controller = TextEditingController();

  return showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Rename Album'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'New Name'),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, _controller.text.trim());
            },
            child: Text('Rename'),
          ),
        ],
      );
    },
  );
}

Future<void> _updateAlbumTitle(String newName) async {
  // Access the current user directly
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Update Firestore document with the new album title
  CollectionReference _firestoreReference =
      FirebaseFirestore.instance.collection('Users/${currentUser?.uid}/albums');

  DocumentReference albumDocRef = _firestoreReference.doc(widget.album.id);

  await albumDocRef.update({'title': newName});
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<String>(
          stream: _getAlbumTitleStream(),
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
          preferredSize: Size.fromHeight(4.0),
          child: Divider(
            color: const Color.fromRGBO(158, 158, 158, 1),
            height: 0.0,
          ),
        ),
      ),

      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              PopupMenuButton<String>(
      onSelected: (String choice) {
        // Handle the selection from the pop-up menu
        if (choice == 'Pictures') {
          // Implement sorting by pictures logic
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImageDisplayScreen(albumId: widget.albumId, album: widget.album,), // current user might now work
            ),
          );
        } else if (choice == 'Videos') {
          // Implement sorting by videos logic
          Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VideoDisplayScreen(albumId: widget.albumId, album: widget.album,)),
              );

        }
      },
      itemBuilder: (BuildContext context) {
        return ['Pictures', 'Videos'].map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Text(
            'Sort by',
            style: TextStyle(
              color: Color.fromRGBO(69, 48, 178, 1),
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    ),


              PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return ['Delete', 'Rename'].map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
      onSelected: (String choice) async {
        // Handle the selection from the pop-up menu
        if (choice == 'Delete') {
          // Implement delete logic
          _deleteAlbum();
        } else if (choice == 'Rename') {
          // Implement rename logic
          // Show a dialog to get the new name for the album
      String? newName = await _showRenameDialog(context);

      if (newName != null && newName.isNotEmpty) {
        // Update the title of the album in Firestore
        await _updateAlbumTitle(newName);
      }
        }
      },
      
    ),
            ],
          ),
          Expanded(

      
      child: StreamBuilder<List<VideoModel>>(
        stream: _videoStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            List<VideoModel> videos = snapshot.data ?? [];
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Handle video tap
        //             Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => VideoFullScreen(videoUrl:videos[index].videoUrl)
        //   ),
        // );
                  },
                  child: Card(
        // Your existing Card widget code here
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
          child: Image.network(videos[index].thumbnailUrl, fit: BoxFit.cover),
        ),
                      ),
                );
              },
            );
          }
        },
      ),),],),
      floatingActionButton: Positioned(
        bottom: 16.0,
        right: 16.0,
        child: ElevatedButton(
          onPressed: () {
            // Implement your logic for adding more videos
            _uploadVideoToFirebase();
          },
          child: Text("Add more videos"),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavigationButton(Icons.home, () {
              // Navigate to the home screen
            }),
            _buildNavigationButton(Icons.games, () {
              // Navigate to the game library screen
            }),
            _buildNavigationButton(Icons.photo_album, () {
              // Navigate to the album screen
            }),
            _buildNavigationButton(Icons.settings, () {
              // Navigate to the settings screen
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30.0,
        color: Color(0xff959595),
      ),
      onPressed: onPressed,
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
