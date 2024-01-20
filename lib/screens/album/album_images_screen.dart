// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/image_screen.dart';
import 'package:gunita20/services/firebase_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gunita20/screens/album/upload_image.dart';
import 'package:gunita20/screens/album/upload_video.dart';
import 'package:gunita20/screens/album/upload_sound.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:path/path.dart';
import 'image_model.dart';

class AlbumImagesScreen extends StatefulWidget {
  final User? currentUser;
  final MyAlbum album;

  const AlbumImagesScreen({Key? key, required this.album, required this.currentUser}) : super(key: key);

  @override
  _AlbumImagesScreenState createState() => _AlbumImagesScreenState();

  
}

class _AlbumImagesScreenState extends State<AlbumImagesScreen> {

  final ImagePicker _imagePicker = ImagePicker();
  List<ImageModel> images = [];
  List<String> _imageUrls = [];
  List<String> _imageTexts = [];

  final FirebaseService firebaseService = FirebaseService();
  List<MyAlbum> albums = [];


    @override
  void initState() {
    super.initState();
    _imageUrls = widget.album.imageUrls;
    _imageTexts = List<String>.filled(_imageUrls.length, '');
    _loadAlbums();
 // Initialize empty text for each image
  }

  Future<void> _loadAlbums() async {
    final List<MyAlbum> loadedAlbums = await firebaseService.getAlbums();
    setState(() {
      albums = loadedAlbums;
    });
  }
  


  Future<void> _uploadImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    File imageFile = File(pickedFile.path);
    String fileName = basename(imageFile.path);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference reference =
        storage.ref().child('${widget.album.id}/$fileName');

    UploadTask uploadTask = reference.putFile(imageFile);

    uploadTask.whenComplete(() async {
      String imageUrl = await reference.getDownloadURL();
      setState(() {
        _imageUrls.add(imageUrl);
        _imageTexts.add(''); // Add an empty text for the new image
      });

      // Update the album's imageUrls list and imageTexts list in Firebase
      widget.album.imageUrls.add(imageUrl);
      // widget.album.imageTexts.add(''); // Add an empty text for the new image

      // Update the album's imageUrls list in Firebase here
      // For example, if you have a Firestore collection named 'albums'
      // you can update it like this:
      FirebaseFirestore.instance.collection('albums').doc(widget.album.id).update({
        'imageUrls': FieldValue.arrayUnion([imageUrl]),
      });
    }).catchError((onError) {
      print('Error uploading image: $onError');
    });
  }

  @override
  Widget build(BuildContext context) {
  //   if (album == null) {
  //   // Handle the case where album is not initialized yet
  //   return CircularProgressIndicator(); // or any other loading indicator
  // }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 60,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "What would you like to add to this album?",
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Magdelin',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadImagesScreen(album: widget.album, currentUser: widget.currentUser,), // current user might not work
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(320, 80),
                          primary: Color.fromARGB(221, 224, 224, 224).withOpacity(0.5),
                        ),
                        child: Text(
                          "Pictures",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadVideoScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(320, 80),
                          primary: Color.fromARGB(221, 224, 224, 224).withOpacity(0.5),
                        ),
                        child: Text(
                          "Video",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UploadAudioScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(320, 80),
                          primary: Color.fromARGB(221, 224, 224, 224).withOpacity(0.5),
                        ),
                        child: Text(
                          "Sound",
                          style: TextStyle(
                            color: Colors.black,
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
    );
  }
}


  // Widget _buildImageGrid(BuildContext context) {
  //   return GridView.builder(
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 3,
  //     ),
  //     itemCount: images.length,
  //     itemBuilder: (context, index) {
  //       final image = images[index];

  //       return GestureDetector(
  //         onTap: () {
  //           _handleImageTap(context, image);
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //               image: NetworkImage(image.imageUrl),
  //               fit: BoxFit.cover,
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

//   void _handlePicturesButtonClick(BuildContext context) async {
//     final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         images.add(ImageModel(id: images.length.toString(), imageUrl: pickedFile.path, textInfo: ""));
//       });
//     }
//   }

//   void _handleImageTap(BuildContext context, ImageModel image) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ImageWithTextScreen(image: image),
//       ),
//     );
//   }
// }

// class VideoScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Screen'),
//       ),
//       body: Center(
//         child: Text('This is the Video Screen'),
//       ),
//     );
//   }
// }

// class SoundScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sound Screen'),
//       ),
//       body: Center(
//         child: Text('This is the Sound Screen'),
//       ),
//     );
//   }
// }

// class ImageWithTextScreen extends StatefulWidget {
//   final ImageModel image;

//   const ImageWithTextScreen({Key? key, required this.image}) : super(key: key);

//   @override
//   _ImageWithTextScreenState createState() => _ImageWithTextScreenState();
// }

// class _ImageWithTextScreenState extends State<ImageWithTextScreen> {
//   final TextEditingController _textEditingController = TextEditingController();

//   @override
//   void dispose() {
//     _textEditingController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(' ${widget.image.textInfo}'),
//         backgroundColor: Color(0xff4f22cd),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => PhotoView(imageProvider: NetworkImage(widget.image.imageUrl)),
//                   ),
//                 );
//               },
//               child: Image.network(widget.image.imageUrl),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               controller: _textEditingController,
//               decoration: InputDecoration(
//                 labelText: 'Edit the title for this image',
//                 labelStyle: TextStyle(fontSize: 23),
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   widget.image.textInfo = value;
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
