// CURRENTLY NOT IN USE 

// // by easy approach youtube channel
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter_absolute_path/flutter_absolute_path.dart'; // incompatible



// class UploadScreen extends StatefulWidget {
//   const UploadScreen({super.key});

//   @override
//   State<UploadScreen> createState() => _UploadScreenState();
// }

// class _UploadScreenState extends State<UploadScreen> {

//   FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//   FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

//   List<UploadTask> uploadedTask = [];
//   // List<UploadTask>.filled(500, 0 as UploadTask, growable: true);
  
//   List<File> selectedFiles = [];
//   // List<File>.filled(500, 0 as File, growable: true);


//   Future selectFiletoUpload() async {
//     try{

//       FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true, type: FileType.image);

//       if(result !=null) {

//         // result.files // these are the selected files
//         result.files.forEach((selectedFile) async {
//           final File fileForfirebase = File(selectedFile.path); // from YT tutorial that aint working


//           selectedFiles.add(fileForfirebase);
//         });

//       }else{
//         print("CANCELLED!!!!");
//       }
//     }catch(e) {
//       print(e);
//     }
//   }
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Gallery"),
//       ),
//       floatingActionButton: FloatingActionButton (onPressed: () {
//         // insert function here
//       },
//       child: Icon(Icons.add),
//       ),
//       body: uploadedTask.length == 0 ? Center(child: Text('No pics being uploaded. Click add button to upload images')) : Container(),
//     );
//   }
// }

// class FlutterAbsolutePath {
// }