// JASPER
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:transparent_image/transparent_image.dart';

class AddPhoto extends StatefulWidget {
  final String albumName;

  const AddPhoto(this.albumName, {super.key});

  @override
  _AddPhotoState createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  int _hoveredIndex = -1;

  late CollectionReference imgRef; //Non-nullable instance field 'imgRef' must be initialized. Try adding an initializer expression, or a generative constructor that initializes it, or mark it 'late'.
  late firebase_storage.Reference ref;

  final List<File> _image = [];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7f9f9),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(
                  'Your Memories',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4f22cd),
                  ),
                ),
                PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.add_photo_alternate, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Add Photos'),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 2,
                      child: Row(
                        children: [
                          Icon(Icons.edit, color: Colors.black),
                          SizedBox(width: 8),
                          Text('Rename Album'),
                        ],
                      ),
                    ),
                    PopupMenuItem<int>(
                      value: 3,
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Delete Album',
                              style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 1) {
                      // Handle Add Photos option
                    } else if (value == 2) {
                      // Handle Rename Album option
                    } else if (value == 3) {
                      // Handle Delete Album option
                    }
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(height: 8),
                  Text(
                    widget.albumName,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  _inputField(context),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => AddImage()));
                      // chooseImage();
                      // uploadFile();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 30,
                          color: Color(0xffffffff),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Add photos',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff4f22cd),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      minimumSize: Size(200, 60),
                    ),
                  ),
                  StreamBuilder(stream: FirebaseFirestore.instance.collection('imageURLs').snapshots(),
      builder: (context,AsyncSnapshot snapshot) {
        return !snapshot.hasData
              ? Center(
                  child: CircularProgressIndicator(), 
              )
              : Container(
                child: GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount (
                  crossAxisCount: 3),
                 itemBuilder: (context,index) {
                  return Container(
                    margin: EdgeInsets.all(3),
                    child: FadeInImage.memoryNetwork(
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage, 
                      image: snapshot.data!.docs[index].get('url')),
                  );
                }),
              );
      },
      ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
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
                    MaterialPageRoute(builder: (context) => Container()),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField(BuildContext context) {
    // Implement your input field widget here
    return Container();
  }

  void _handleMouseEnter(int index) {
    setState(() {
      _hoveredIndex = index;
    });
  }

  void _handleMouseExit() {
    setState(() {
      _hoveredIndex = -1;
    });
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: Color(0xff8a8a8a),
      ),
      onPressed: onPressed,
    );
  }
  
  chooseImage() async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery); // getImage is deprecated so changed to pickImage
  setState(() {
    _image.add(File(pickedFile!.path)); // PickerFile?.path was not working
  });
  if (pickedFile!.path == null) retrieveLostData();
}

Future<void> retrieveLostData() async {     
  final LostDataResponse response = await picker.retrieveLostData(); // getLostData is deprecated so changed to retrieveloastdata and lostdata was changed to lostdatarepsones 
  if (response.isEmpty) {
    return;
  }
  if (response.file != null) {
    setState(() {
      _image.add(File(response.file!.path));
    });
  } else {
    print(response.file);
  }
}

Future uploadFile() async {
  for (var img in _image) {
    //creates a reference for every image in our list of images
    ref = firebase_storage.FirebaseStorage.instance 
        .ref()
        .child('images/${Path.basename(img.path)}');

    // puts       this v image in that reference
    await ref.putFile(img).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        imgRef.add({'url': value});  // this value lets us retrieve those images from firebase and display here in app
      });
    });
  }
}

@override
  void initState() {
    
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs'); // downloadable url value will be added in this reference in our firebase
  }
}

