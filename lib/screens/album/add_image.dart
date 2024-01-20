// currently not used and is substituted by chat GPT
// // LAZYTECHNO TUTORIAL

// // ignore_for_file: prefer_const_constructors
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:gunita20/screens/album/home_gallery.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:path/path.dart' as Path;

// class AddImage extends StatefulWidget {
//   const AddImage({super.key});

//   @override
//   State<AddImage> createState() => _AddImageState();
// }



// class _AddImageState extends State<AddImage> {

//   late CollectionReference imgRef; //Non-nullable instance field 'imgRef' must be initialized. Try adding an initializer expression, or a generative constructor that initializes it, or mark it 'late'.
//   late firebase_storage.Reference ref;

//   List<File> _image = [];
//   final picker = ImagePicker();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: AppBar(
//       backgroundColor: Colors.purple[900],
//       title: Text('Add Image'),
//       actions: [TextButton(onPressed: (){
//         uploadFile().whenComplete(() => Navigator.push(context, MaterialPageRoute(builder: (context) => HomeGallery())));
//       },
//        child: Text('Upload',
//        style: TextStyle(color: Colors.white),))], // upload selected imgs from gallery to firebase
//        ),
       
//        // GRID VIEW FOR GALLERY DISPLAY
//        body: GridView.builder(
//         itemCount: _image.length+1,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//         itemBuilder: (context,index) {
//         return index == 0
//             ? Center(
//               child: IconButton(icon: Icon(Icons.add),
//               onPressed: () {
//                 chooseImage();
//               },
//               ),
//             )
//           : Container(margin: EdgeInsets.all(3),
//           decoration: BoxDecoration(image: DecorationImage(image: FileImage(_image[index-1]),
//           fit: BoxFit.cover)),
//           );
//        }),
//        );
//   }


//   chooseImage() async {
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery); // getImage is deprecated so changed to pickImage
//   setState(() {
//     _image.add(File(pickedFile!.path)); // PickerFile?.path was not working
//   });
//   if (pickedFile!.path == null) retrieveLostData();
// }

// Future<void> retrieveLostData() async {     
//   final LostDataResponse response = await picker.retrieveLostData(); // getLostData is deprecated so changed to retrieveloastdata and lostdata was changed to lostdatarepsones 
//   if (response.isEmpty) {
//     return;
//   }
//   if (response.file != null) {
//     setState(() {
//       _image.add(File(response.file!.path));
//     });
//   } else {
//     print(response.file);
//   }
// }

// Future uploadFile() async {
//   for (var img in _image) {
//     //creates a reference for every image in our list of images
//     ref = firebase_storage.FirebaseStorage.instance 
//         .ref()
//         .child('images/${Path.basename(img.path)}');

//     // puts       this v image in that reference
//     await ref.putFile(img).whenComplete(() async {
//       await ref.getDownloadURL().then((value) {
//         imgRef.add({'url': value});  // this value lets us retrieve those images from firebase and display here in app
//       });
//     });
//   }
// }

// @override
//   void initState() {
    
//     super.initState();
//     imgRef = FirebaseFirestore.instance.collection('imageURLs'); // downloadable url value will be added in this reference in our firebase
//   }
// }

