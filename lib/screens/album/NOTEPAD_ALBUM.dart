// // INCORPORATE JASPER'S DESIGN
// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:gunita20/screens/album/create_album_screen.dart';
// import 'package:gunita20/screens/gamelibrary_screen.dart';
// import 'package:gunita20/screens/home_screen.dart';
// import 'package:gunita20/screens/settings/settings_screen.dart';


// class Album extends StatefulWidget {
//   @override
//   _AlbumState createState() => _AlbumState();
// }

// class _AlbumState extends State<Album> {
//   int _hoveredIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => CreateAlbum(),
//             ),
//           );
//         },
//         child: Container(
//           color: Color(0xff4f22cd),
//           child: Stack(
//             children: [
//               Positioned(
//                 top: MediaQuery.of(context).size.height * 0.40,
//                 left: 0,
//                 right: 0,
//                 bottom: 0,
//                 child: Container(
//                   margin: EdgeInsets.symmetric(horizontal: 0.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(40),
//                   ),
//                   child: Column(children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20.0),
//                       child: Text(
//                         'Your Memories',
//                         style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xff3b0d6b),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => CreateAlbum()),
//                         );
//                       },
//                       child: Text(
//                         "Create Album",
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         primary: Color(0xff4f22cd),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                         minimumSize: Size(300, 60),
//                       ),
//                     ),
//                   ]),
//                 ),
//               ),
//               Positioned.fill(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.all(20),
//                         child: Text(
//                           'Teresa Stonesteel',
//                           style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.bold,
//                             color: Color(0xfffffeff),
//                           ),
//                         ),
//                       ),
//                     ),

                    
//                     Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(1.0),
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _buildNavigationButton(Icons.home, () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => HomeScreen(),
//                               ),
//                             );
//                           }),
//                           _buildNavigationButton(Icons.games, () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => GameLibrary(),
//                               ),
//                             );
//                           }),
//                           _buildNavigationButton(Icons.photo_album, () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => CreateAlbum(),
//                               ),
//                             );
//                           }),
//                           _buildNavigationButton(Icons.settings, () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Settings()),
//                             );
//                           }),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
//     return IconButton(
//       icon: Icon(
//         icon,
//         size: 30,
//         color: Color(0xff959595),
//       ),
//       onPressed: onPressed,
//     );
//   }
// }

// // albums_screen.dart
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:gunita20/screens/album/add_album_screen.dart';
// import 'package:gunita20/screens/album/album_images_screen.dart';
// import 'package:gunita20/screens/album/album_model.dart';
// import 'package:gunita20/services/firebase_service.dart';


// class Album extends StatefulWidget {
//   @override
//   _AlbumState createState() => _AlbumState();
// }

// class _AlbumState extends State<Album> {
//   final FirebaseService firebaseService = FirebaseService();
//   List<MyAlbum> albums = [];

//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // testing

//   Future<User?> _getUser() async {
//     return _auth.currentUser;
//   }

//   @override
//   void initState() {
//     super.initState();
//     _loadAlbums();
//   }

//   Future<void> _loadAlbums() async {
//     final List<MyAlbum> loadedAlbums = await firebaseService.getAlbums();
//     setState(() {
//       albums = loadedAlbums;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Albums'),
//       ),
//       // body: ListView.builder(
//       //   itemCount: albums.length,
//       //   itemBuilder: (context, index) {
//       //     final album = albums[index];
//       //     return ListTile(
//       //       title: Text(album.title),
//       //       onTap: () {
//       //         Navigator.push(
//       //           context,
//       //           MaterialPageRoute(
//       //             builder: (context) => AlbumImagesScreen(album: album),
//       //           ),
//       //         );
//       //       },
//       //     );
//       //   },
//       // ),
//       body: FutureBuilder<User?>(
//         future: _getUser(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.data != null) {
//               return AlbumList(currentUser: snapshot.data!);
//             } else {
//               return CircularProgressIndicator();
//             }
//           } else {
//             return CircularProgressIndicator();
//           }
//         },
//       ),


//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddAlbumScreen(),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }



// class AlbumList extends StatelessWidget {       //  Uses StreamBuilder to display albums real time
//   final User currentUser;

//   AlbumList({required this.currentUser});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('users/${currentUser.uid}/albums').snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           final albums = snapshot.data!.docs.map((doc) => MyAlbum(id: doc.id, title: doc['title'], imageUrls: [])).toList();
//           return ListView.builder(
//             itemCount: albums.length,
//             itemBuilder: (context, index) {
//               final album = albums[index];
//               return ListTile(
//                 title: Text(album.title),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => AlbumImagesScreen(currentUser: currentUser, album: album),
//                     ),
//                   );
//                 },
//               );
//             },
//           );
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }