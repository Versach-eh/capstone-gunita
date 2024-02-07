import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditImageDetailsScreen extends StatefulWidget {
  final String imageUrl;
  final String albumId;

  const EditImageDetailsScreen({Key? key, required this.imageUrl, required this.albumId}) : super(key: key);

  @override
  _EditImageDetailsScreenState createState() => _EditImageDetailsScreenState();
}

class _EditImageDetailsScreenState extends State<EditImageDetailsScreen> {
  bool _isShowingNotes = false; // Variable to track whether to show the notes section
  bool _isNotesButtonPressed = true;
  bool _isAudioNotesButtonPressed = false; // Variable to track whether to show the notes section

  TextEditingController _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchImageDetails();
  }

  Future<void> _fetchImageDetails() async {
    try {
      DocumentSnapshot imageSnapshot = await FirebaseFirestore.instance
          .doc('Users/${FirebaseAuth.instance.currentUser!.uid}/albums/${widget.albumId}')
          .get();

      Map<String, dynamic>? imageData = imageSnapshot.data() as Map<String, dynamic>?;

      if (imageData != null) {
        Map<String, dynamic> imageDetails = (imageData['imageDetails'] as Map<String, dynamic>?) ?? {};

        setState(() {
          _isShowingNotes = (imageDetails[widget.imageUrl]?['note'] ?? '').isNotEmpty;
          _notesController.text = imageDetails[widget.imageUrl]?['note'] ?? '';
        });
      }
    } catch (error) {
      print('Error fetching image details: $error');
    }
  }

  void _saveImageDetails() {
    // Add logic to save details to Firebase using widget.albumId and widget.imageUrl
    // For simplicity, let's print the details for now
    // print("Title: ${_titleController.text}");
    print("Note: ${_notesController.text}");
    print("Image URL: ${widget.imageUrl}");
    print("Album ID: ${widget.albumId}");

    // Assuming you have an 'imageDetails' field in your data structure
    Map<String, dynamic> imageDetails = {
      // 'title': _titleController.text,
      'note': _notesController.text,
    };

    // Update Firestore document
    CollectionReference _firestoreReference =
        FirebaseFirestore.instance.collection('Users/${FirebaseAuth.instance.currentUser!.uid}/albums');

    DocumentReference albumDocRef = _firestoreReference.doc(widget.albumId);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot albumDocSnapshot = await transaction.get(albumDocRef);

      if (albumDocSnapshot.exists) {
        // Get existing data
        Map<String, dynamic>? albumData = albumDocSnapshot.data() as Map<String, dynamic>?;

        // Get existing image details or initialize an empty map
        Map<String, dynamic> existingImageDetails =
            (albumData?['imageDetails'] as Map<String, dynamic>?) ?? {};

        // Add/update details for the current image URL
        existingImageDetails[widget.imageUrl] = imageDetails;

        // Update the 'imageDetails' field
        transaction.update(albumDocRef, {'imageDetails': existingImageDetails});
      } else {
        // Handle the case where the document doesn't exist
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 5),
            Text(
              'Let\'s know more about this memory.',
              style: TextStyle(
                fontSize: 23,
                fontFamily: 'Magdelin',
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     ElevatedButton(
            //       onPressed: () {
            //         setState(() {
            //           _isNotesButtonPressed = true;
            //           _isAudioNotesButtonPressed = false;
            //         });
            //       },
            //       style: ElevatedButton.styleFrom(
            //         primary: _isNotesButtonPressed ? Color(0xfffc4530B2) : Colors.white,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(15),
            //           side: BorderSide(
            //             color: Color(0xfffc4530B2),
            //             width: 1.0,
            //           ),
            //         ),
            //         fixedSize: Size(155, 40),
            //       ),
            //       child: Text(
            //         'Notes',
            //         style: TextStyle(
            //           color: _isNotesButtonPressed ? Colors.white : Color(0xfffc4530B2),
            //           fontSize: 16.0,
            //         ),
            //       ),
            //     ),
            //     SizedBox(width: 10),
                
            //   ],
            // ),
            SizedBox(height: 1),
            // Show TextFormField only when _isNotesButtonPressed is true
            if (_isNotesButtonPressed)
              Column(
                children: [
                  TextFormField(
                    controller: _notesController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Tap here to add notes',
                    ),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Save the notes to Firestore when the "Save" button is pressed
                      // _saveNotesToFirestore(_notesController.text);
                      _saveImageDetails();
                      
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xfffc4530B2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fixedSize: Size(155, 40),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            SizedBox(height: 16),
            if (_isShowingNotes)
              Column(
                children: [
                  
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _saveNotesToFirestore(String notes) async {
    try {
      await FirebaseFirestore.instance
          .doc('Users/${FirebaseAuth.instance.currentUser!.uid}/albums/${widget.albumId}')
          .update({
        'imageDetails.${widget.imageUrl}.note': notes,
      });
    } catch (error) {
      print('Error saving notes: $error');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
