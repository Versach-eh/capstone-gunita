// // ignore_for_file: prefer_const_constructors

// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:gunita20/screens/album/album_model.dart';
// import 'package:gunita20/screens/album/image_full_screen.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


// class ImageDisplayScreen extends StatefulWidget {
//   final String albumId;
//     final User? currentUser;
//       final MyAlbum album;



//   const ImageDisplayScreen({Key? key, required this.albumId, this.currentUser, required this.album}) : super(key: key);

//   @override
//   _ImageDisplayScreen createState() => _ImageDisplayScreen();
// }

// class _ImageDisplayScreen extends State<ImageDisplayScreen> {
//   Stream<List<String>> _imageStream = yourImageStreamFunction(); // Replace with your actual function
//   Stream<List<String>> _videoStream = yourVideoStreamFunction(); // Replace with your actual function

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your App Title'),
//       ),
//       body: Column(
//         children: [
//           StreamBuilder<List<String>>(
//             stream: _imageStream,
//             builder: (context, imageSnapshot) {
//               if (imageSnapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (imageSnapshot.hasError) {
//                 return Text("Error: ${imageSnapshot.error}");
//               } else {
//                 List<String> imageUrls = imageSnapshot.data ?? [];
//                 return GridView.builder(
//                   // Build UI using imageUrls
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 4.0,
//                     mainAxisSpacing: 4.0,
//                   ),
//                   itemCount: imageUrls.length,
//                   itemBuilder: (context, index) {
//                     return Image.network(imageUrls[index]);
//                   },
//                 );
//               }
//             },
//           ),
//           StreamBuilder<List<String>>(
//             stream: _videoStream,
//             builder: (context, videoSnapshot) {
//               if (videoSnapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (videoSnapshot.hasError) {
//                 return Text("Error: ${videoSnapshot.error}");
//               } else {
//                 List<String> videoUrls = videoSnapshot.data ?? [];
//                 return GridView.builder(
//                   // Build UI using videoUrls
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 4.0,
//                     mainAxisSpacing: 4.0,
//                   ),
//                   itemCount: videoUrls.length,
//                   itemBuilder: (context, index) {
//                     return VideoWidget(videoUrl: videoUrls[index]);
//                   },
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class VideoWidget extends StatelessWidget {
//   final String videoUrl;

//   const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 16 / 9,
//       child: VideoPlayerWidget(videoUrl: videoUrl),
//     );
//   }
// }

// class VideoPlayerWidget extends StatelessWidget {
//   final String videoUrl;

//   const VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Implement your video player widget here
//     // You might want to use a package like chewie or video_player
//     // Example: ChewieVideoPlayer(url: videoUrl);
//     return Container(
//       color: Colors.black,
//       child: Center(
//         child: Text('Video Player Placeholder'),
//       ),
//     );
//   }
// }

// Stream<List<String>> yourImageStreamFunction() {
//   // Implement your image stream logic here
//   // For example, fetch data from Firestore
//   return FirebaseFirestore.instance
//       .collection('your_image_collection')
//       .snapshots()
//       .map((snapshot) {
//     return snapshot.docs
//         .map((doc) => doc['imageUrl'] as String)
//         .toList();
//   });
// }

// Stream<List<String>> yourVideoStreamFunction() {
//   // Implement your video stream logic here
//   // For example, fetch data from Firestore
//   return FirebaseFirestore.instance
//       .collection('your_video_collection')
//       .snapshots()
//       .map((snapshot) {
//     return snapshot.docs
//         .map((doc) => doc['videoUrl'] as String)
//         .toList();
//   });
// }