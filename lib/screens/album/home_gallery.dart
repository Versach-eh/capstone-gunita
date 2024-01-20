// // LAZYTECHNO TUTORIAL
// currently not used and is substituted by chat GPT
// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gunita20/screens/album/add_image.dart';
// import 'package:transparent_image/transparent_image.dart';

// class HomeGallery extends StatefulWidget {
//   const HomeGallery({super.key});

//   @override
//   State<HomeGallery> createState() => _HomeGalleryState();
// }


// class _HomeGalleryState extends State<HomeGallery> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Album'),
//       backgroundColor: Colors.purple[900],),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.purple[900],
//         child: Icon(Icons.add),
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddImage())); // turorial lazytechno
//         },
//       ),

//       body: StreamBuilder(stream: FirebaseFirestore.instance.collection('imageURLs').snapshots(),
//       builder: (context,AsyncSnapshot snapshot) {
//         return !snapshot.hasData
//               ? Center(
//                   child: CircularProgressIndicator(), 
//               )
//               : Container(
//                 child: GridView.builder(
//                 itemCount: snapshot.data!.docs.length,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (
//                   crossAxisCount: 3),
//                  itemBuilder: (context,index) {
//                   return Container(
//                     margin: EdgeInsets.all(3),
//                     child: FadeInImage.memoryNetwork(
//                       fit: BoxFit.cover,
//                       placeholder: kTransparentImage, 
//                       image: snapshot.data!.docs[index].get('url')),
//                   );
//                 }),
//               );
//       },
//       ),
//     );
//   }
// }