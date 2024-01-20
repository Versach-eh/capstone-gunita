// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/add_album_screen.dart';
import 'package:gunita20/screens/album/album_images_screen.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/screens/album/image_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';
import 'package:gunita20/services/firebase_service.dart';

class Album extends StatefulWidget {

  const Album({Key? key}) : super(key: key);

  @override
  _AlbumState createState() => _AlbumState();
}

class _AlbumState extends State<Album> {
    final FirebaseService firebaseService = FirebaseService();
  List<MyAlbum> albums = [];

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  Stream<List<AlbumWithThumbnail>> _fetchAlbumsStream() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference albumsCollection =
        FirebaseFirestore.instance.collection('Users/$uid/albums');

    return albumsCollection.snapshots().asyncMap((querySnapshot) async {
      List<AlbumWithThumbnail> albumsWithThumbnail = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        String title = data['title'] ?? '';
        List<String> imageUrls = data['imageUrls'] != null
            ? List<String>.from(data['imageUrls'])
            : [];

        // Fetch the first image inside the album
        String thumbnailUrl = imageUrls.isNotEmpty ? imageUrls[0] : '';

        // Create an object containing album details and the thumbnail URL
        AlbumWithThumbnail albumWithThumbnail =
            AlbumWithThumbnail(title: title, thumbnailUrl: thumbnailUrl);

        albumsWithThumbnail.add(albumWithThumbnail);
      }

      return albumsWithThumbnail;
    });
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
      backgroundColor: Color.fromARGB(255, 202, 202, 202),  // Set the background color here
        body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(60.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Your Memories",
                    style: TextStyle(
                      fontSize: 28,
                      fontFamily: 'Magdelin',
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddAlbumScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 119, 119, 119).withOpacity(0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15), // Adjust padding as needed
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center, // Adjust the alignment of the text
                      children: [
                        SizedBox(width: 14),
                        Text(
                          'Create an album',
                          style: TextStyle(
                            fontSize: 24, // Adjust font size as needed
                            fontFamily: 'Magdelin',
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                      _buildAlbumList(),


                  
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                    color: Colors.white,
                    width: 4.0,
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(30), // Adjust padding as needed for the circle size
                child: Icon(
                  Icons.photo,
                  size: 30, // Adjust the size of the icon
                  color: Colors.black,
                ),
              ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Test123",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Magdelin',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Birthday:",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Magdelin',
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Age:",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Magdelin',
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 224, 224, 224).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavigationButton(Icons.home, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }),
            _buildNavigationButton(Icons.games, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameLibrary()),
              );
            }),
            _buildNavigationButton(Icons.photo_album, () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Album()),
              // );
            }),
            _buildNavigationButton(Icons.settings, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySettings()),
              );
            }),
          ],
        ),
      ),
    );
  }

  // WIDGET for displaying all the ALBUMS
Widget _buildAlbumList() {
  return Expanded(
    child: ListView.builder(
      itemCount: albums.length,
      itemBuilder: (context, index) {
        final album = albums[index];
        return InkWell(
          onTap: () {
            if (album.imageUrls.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDisplayScreen(
                    albumId: album.id,  // Pass the album ID to ImageDisplayScreen
                    currentUser: null,
                    album: album,
                  ),
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AlbumImagesScreen(
                    album: album,
                    currentUser: null,
                  ),
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Display the first image as a thumbnail
                album.imageUrls.isNotEmpty
                    ? Image.network(
                        album.imageUrls[0],
                        width: 50, // Adjust the size as needed
                        height: 50,
                        fit: BoxFit.cover,
                      )
                    : Container(), // Placeholder if there's no image
                SizedBox(width: 16.0),
                Text(album.title),
              ],
            ),
          ),
        );
      },
    ),
  );
}



  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30.0,
        color: const Color.fromARGB(255, 133, 133, 133),
      ),
      onPressed: onPressed,
    );
  }

  void _onTabTapped(int index) {
    // Existing code...
  }
}

class AlbumWithThumbnail {
  final String title;
  final String thumbnailUrl;

  AlbumWithThumbnail({required this.title, required this.thumbnailUrl});
}
  
  
