import 'package:flutter/material.dart';
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
  TextEditingController _additionalField1Controller = TextEditingController();
  TextEditingController _additionalField2Controller = TextEditingController();
  DateTime? selectedDateFromDetails;
  TimeOfDay? selectedTimeFromDetails;
  Category? selectedCategory;

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
              color: const Color.fromARGB(255, 184, 183, 183).withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white, width: 2.0),
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
                          fontSize: 18.0,
                          fontFamily: 'Magdelin',
                          color: Colors.black,
                        ),
                      ),
                      hintText: 'Enter title here...',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Magdelin',
                        color: Colors.black,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Magdelin',
                    ),
                    onChanged: (value) {
                      // Handle text changes if needed
                    },
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2.0,
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Insert description here...',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
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
              color: const Color.fromARGB(255, 184, 183, 183).withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white, width: 2.0),
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
                  selectedDateFromDetails != null && selectedTimeFromDetails != null
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
              color: const Color.fromARGB(255, 184, 183, 183).withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: ElevatedButton(
              onPressed: () async {
                Map<String, dynamic>? result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(),
                ),
              );

                if (result != null && result.containsKey('selectedCategory')) {
                Category? selectedCategory = result['selectedCategory'] as Category?;
                setState(() {
                  this.selectedCategory = selectedCategory;
                });
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
                child: Text(
                  selectedCategory != null
                      ? selectedCategory!.name
                      : 'Add category',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Magdelin',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
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
                    fixedSize: Size(150, 50),
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
                  onPressed: () {
                    // Handle Next button press
                  },
                  child: Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    fixedSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
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
