// added the creation of album in database

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_images_screen.dart';
import 'package:gunita20/screens/album/album_model.dart';
import 'package:gunita20/services/firebase_service.dart';
import 'package:uuid/uuid.dart';



class AddAlbumScreen extends StatefulWidget {
  const AddAlbumScreen({Key? key}) : super(key: key);

  @override
  _AddAlbumScreenState createState() => _AddAlbumScreenState();
}

class _AddAlbumScreenState extends State<AddAlbumScreen> {
  final TextEditingController _titleController = TextEditingController();
    final FirebaseService firebaseService = FirebaseService();


// CREATES THE ALBUM IN FIREBASE HERE
   void _submitForm() {
    String uniqueId = Uuid().v4(); // Generate a unique random string
    final String title = _titleController.text.trim();
    
    if (title.isNotEmpty) {
      final MyAlbum newAlbum = MyAlbum(id: uniqueId , title: title, imageUrls: [],);
      firebaseService.addAlbum(newAlbum);
      Navigator.of(context).pop();
      // Navigator.push(context,
      // MaterialPageRoute(builder: (context) => AlbumImagesScreen()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 150),
            Text(
              'What would you like to name this album?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Magdelin',
              ),
            ),
            SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: const Color.fromARGB(255, 117, 117, 117)),
              ),
              child: TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close button
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    fixedSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Cancel', style: TextStyle(fontSize: 20.0)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: const Text('Next', style: TextStyle(fontSize: 20.0)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AddAlbumScreen(),
  ));
}
