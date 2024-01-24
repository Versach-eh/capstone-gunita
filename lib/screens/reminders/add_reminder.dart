import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/services/firebase_service.dart';
import 'package:intl/intl.dart';
import 'package:gunita20/screens/reminders/category.dart';
import 'package:gunita20/screens/reminders/date_time.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  DateTime? selectedDateFromDetails;
  TimeOfDay? selectedTimeFromDetails;
  List<Category>? selectedCategory;

  Future<void> addReminderToFirestore() async {
    try {
      final String userId = FirebaseService().user.uid;
      String title = _titleController.text.trim();

      // Check if the title already exists in Firestore
      bool titleExists = await _checkIfTitleExists(userId, title);

      if (titleExists) {
        // Show a dialog if the title already exists
        _showTitleExistsDialog();
      } else {
        List<Map<String, dynamic>> categoryDataList = [];

        if (selectedCategory != null) {
          for (Category category in selectedCategory!) {
            categoryDataList.add({
              'name': category.name,
              'color': "0x${category.color.value.toRadixString(16)}",
            });
          }
        }

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userId)
            .collection("reminders")
            .add({
          "reminderCreatedAt": FieldValue.serverTimestamp(),
          "title": title,
          "description": _descriptionController.text,
          "date": selectedDateFromDetails,
          "time": selectedTimeFromDetails!.format(context),
          "categories": categoryDataList,
          "isFinished": false,
        });

        // Optionally, you can clear the text controllers after adding the reminder
        _titleController.clear();
        _descriptionController.clear();

        Navigator.pop(context);
      }
    } catch (e) {
      print("Error adding reminder to Firestore: $e");
    }
  }

  Future<bool> _checkIfTitleExists(String userId, String title) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("reminders")
          .where("title", isEqualTo: title)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking if title exists: $e");
      return false;
    }
  }

  void _showTitleExistsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Reminder Already Exists'),
          content: Text(
              'A reminder with the same title already exists. Please name a different one.'),
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

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Reminder'),
          content: Text('Are you sure you want to cancel?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                'No',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pop(context); // Close the ReminderScreen
              },
              child: Text(
                'Yes',
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
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 50),
          Text(
            'What would you like to be\nreminded of?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Magdelin',
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 300,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xfffc4530B2), width: 2.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      prefix: Text(
                        'Title: ',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Magdelin',
                          color: Colors.black,
                        ),
                      ),
                      hintText: 'Add title here',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Magdelin',
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'Magdelin',
                    ),
                    onChanged: (value) {
                      // Handle text changes if needed
                    },
                  ),
                  Divider(
                    color: Color(0xfffc4530B2),
                    thickness: 2.0,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Insert description here',
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Magdelin',
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Magdelin',
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xfffc4530B2), width: 2.0),
            ),
            child: ElevatedButton(
              onPressed: () async {
                // Navigate to DateTimeScreen and wait for the result
                Map<String, dynamic>? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DateTimeScreen(),
                  ),
                );

                // Update the button text if data is returned
                if (result != null) {
                  setState(() {
                    selectedDateFromDetails = result['selectedDate'];
                    selectedTimeFromDetails = result['selectedTime'];
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.transparent,
                elevation: 0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  selectedDateFromDetails != null &&
                          selectedTimeFromDetails != null
                      ? 'Date: ${DateFormat('dd/MM/yyyy').format(selectedDateFromDetails!)} - Time: ${selectedTimeFromDetails!.format(context)}'
                      : 'Details (Date & Time, etc...)',
                  style: TextStyle(
                    fontSize: 19.0,
                    fontFamily: 'Magdelin',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 300,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color(0xfffc4530B2), width: 2.0),
            ),
            child: ElevatedButton(
              onPressed: () async {
                Map<String, dynamic>? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryScreen(),
                  ),
                );

                if (result != null) {
                  List<Category>? selectedCategory =
                      result['selectedCategory'] as List<Category>?;
                  setState(() {
                    this.selectedCategory = selectedCategory;
                  });

                  print('Selected Categories: $selectedCategory');
                }
                // Handle the case where 'selectedCategory' is null if no category is selected
                else {
                  setState(() {
                    this.selectedCategory = null;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                onPrimary: Colors.transparent,
                elevation: 0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                      selectedCategory != null && selectedCategory!.isNotEmpty
                          ? selectedCategory!.map((category) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    margin: const EdgeInsets.only(right: 8.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: category.color,
                                    ),
                                  ),
                                  Text(
                                    category.name,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: 'Magdelin',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              );
                            }).toList()
                          : [
                              Text(
                                'Add category',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: 'Magdelin',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showCancelDialog();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: Size(150, 45),
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
                  onPressed: () async {
                    await addReminderToFirestore();
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xfffc4530B2),
                    fixedSize: Size(150, 45),
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
