import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:gunita20/screens/loading.dart';

import 'image_model.dart';

class UploadAudioScreen extends StatefulWidget {
  @override
  _UploadAudioScreenState createState() => _UploadAudioScreenState();
}

class _UploadAudioScreenState extends State<UploadAudioScreen> {
  List<ImageModel> images = [];
  List<String> _imageUrls = [];

  // @override
  // void initState() {
  //   super.initState();
  //   _imageUrls = widget.album.imageUrls;
  // }

  // Future<void> _uploadImageToFirebase() async {
  //   final user = FirebaseAuth.instance.currentUser!;

  //   final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     final ref = firebase_storage.FirebaseStorage.instance
  //         .ref()
  //         .child('Users/${widget.currentUser.uid}/albums/${widget.album.id}/${pickedFile.path.split('/').last}');
  //     final uploadTask = ref.putFile(
  //       File(pickedFile.path),
  //       firebase_storage.SettableMetadata(contentType: 'image/jpeg'),
  //     );

  //     await uploadTask.whenComplete(() async {
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return Loading();
  //         },
  //       );

  //       String downloadUrl = await ref.getDownloadURL();

  //       setState(() {
  //         images.add(ImageModel(id: images.length.toString(), imageUrl: downloadUrl, textInfo: ""));
  //       });

  //       widget.album.imageUrls.add(downloadUrl);

  //       CollectionReference _firestoreReference = FirebaseFirestore.instance.collection('Users/${user.uid}/albums');
  //       late Stream<QuerySnapshot> _stream;
  //       _stream = _firestoreReference.snapshots();

  //       _firestoreReference.doc(widget.album.id).update({
  //         'imageUrls': FieldValue.arrayUnion([downloadUrl]),
  //       });
  //     });
  //   }
  // }

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
                    "to upload a sound.",
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
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(220, 200),
                          primary: Color.fromARGB(221, 224, 224, 224).withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          "Add sound",
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
}

//   Widget _buildImageGrid(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//       ),
//       itemCount: images.length,
//       itemBuilder: (context, index) {
//         final image = images[index];

//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ImageWithTextScreen(image: image),
//               ),
//             );
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: NetworkImage(image.imageUrl),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//         );
//       },
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
