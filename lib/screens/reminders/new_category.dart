import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gunita20/services/firebase_service.dart';

class NewCategoryScreen extends StatefulWidget {
  const NewCategoryScreen({Key? key}) : super(key: key);

  @override
  _NewCategoryScreenState createState() => _NewCategoryScreenState();
}

class _NewCategoryScreenState extends State<NewCategoryScreen> {
  TextEditingController _titleController = TextEditingController();

  List<Color> colorChoices = [
    Colors.red,
    Colors.blueAccent,
    Colors.lightGreen,
    Colors.yellowAccent,
    Colors.deepPurple,
  ];

  Color selectedColor = Colors.red; // Default color

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> onSaveButtonPressed() async {
    try {
      final String userId = FirebaseService().user.uid;

      // Get the category name and color from the text field and selected color
      String categoryName = _titleController.text.trim();
      String categoryColor = selectedColor.value.toRadixString(16);

      // Check if the category name already exists in Firestore
      bool categoryExists = await _checkIfCategoryExists(userId, categoryName);

      if (categoryExists) {
        // Show a dialog if the category already exists
        _showCategoryExistsDialog();
      } else {
        // Save the new category to Firestore
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userId)
            .collection("categories")
            .add({
          "name": categoryName,
          "color": "0x$categoryColor",
        });

        // Navigate back to the previous screen
        Navigator.pop(context);
      }
    } catch (e) {
      print("Error saving category to Firestore: $e");
    }
  }

  Future<bool> _checkIfCategoryExists(
      String userId, String categoryName) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("categories")
          .where("name", isEqualTo: categoryName)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking if category exists: $e");
      return false;
    }
  }

  void _showCategoryExistsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Category Already Exists'),
          content: Text(
              'A category with the same name already exists. Please name a different one.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'OK',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(40.0),
        children: [
          SizedBox(height: 80),
          Text(
            'Add a New Category',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Magdelin',
            ),
          ),
          SizedBox(height: 70),
          Container(
            width: 320,
            height: 250,
            decoration: BoxDecoration(
              color: const Color(0xfffcE3EDF9),
              borderRadius: BorderRadius.circular(15),
              // border: Border.all(color: Colors.white, width: 1.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                        border: InputBorder.none,
                        hintText: 'Category name',
                        hintStyle: TextStyle(
                          fontSize: 22.0,
                          fontFamily: 'Magdelin',
                          color: Colors.black,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Magdelin',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Choose color:',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22.0,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: colorChoices.map((Color color) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColor = color;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: selectedColor == color
                                  ? Colors.black
                                  : Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: Size(140, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: onSaveButtonPressed,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xfffc4530B2),
                    fixedSize: Size(140, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
