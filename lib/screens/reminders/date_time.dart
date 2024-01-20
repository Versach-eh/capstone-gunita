import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';

class DateTimeScreen extends StatefulWidget {
  const DateTimeScreen({Key? key}) : super(key: key);

  @override
  _DateTimeScreenState createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  String repeatOption = 'No Repeat'; // Default repeat option

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 50),
          Text(
            'When to remind?',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Magdelin',
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 2.0,
          ),
          SizedBox(height: 40),
          buildDateTimeButton(
            text: selectedDate != null
                ? 'Date: ${DateFormat('dd/MM/yyyy').format(selectedDate!)}'
                : 'Tap to set date',
            onPressed: () async {
              // Show Date Picker
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
            icon: Icons.date_range,
          ),
          SizedBox(height: 20),
          buildDateTimeButton(
            text: selectedTime != null
                ? 'Time: ${selectedTime!.format(context)}'
                : 'Tap to set time',
            onPressed: () async {
              // Show Time Picker
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                setState(() {
                  selectedTime = pickedTime;
                });
              }
            },
            icon: Icons.access_time,
          ),
          SizedBox(height: 20),
          buildElevatedButton(
            text: 'Repeat: $repeatOption',
            icon: Icons.repeat,
            onPressed: () {
              _showRepeatOptionsDialog();
            },
          ),
          SizedBox(height: 20),
          buildElevatedButton(
            text: 'Notifications',
            icon: Icons.notifications,
            onPressed: () {
              // Handle Notifications button press
            },
          ),
          SizedBox(height: 100),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Back button press
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
                    _saveDataAndNavigateBack();
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

  Widget buildElevatedButton(
      {required String text,
      required IconData icon,
      required VoidCallback onPressed}) {
    return Container(
      width: 300,
      height: 70,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 184, 183, 183).withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          elevation: 0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30.0,
                color: Colors.black,
              ),
              SizedBox(width: 16),
              Text(
                text,
                style: TextStyle(
                  fontSize: 23.0,
                  fontFamily: 'Magdelin',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDateTimeButton(
      {required String text,
      required VoidCallback onPressed,
      required IconData icon}) {
    return Container(
      width: 300,
      height: 70,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 184, 183, 183).withOpacity(0.5),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onPrimary: Colors.transparent,
          elevation: 0,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30.0,
                color: Colors.black,
              ),
              SizedBox(width: 16),
              Text(
                text,
                style: TextStyle(
                  fontSize: 23.0,
                  fontFamily: 'Magdelin',
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRepeatOptionsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Repeat Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('No Repeat'),
                onTap: () {
                  _setRepeatOption('No Repeat');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Daily'),
                onTap: () {
                  _setRepeatOption('Daily');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Weekly'),
                onTap: () {
                  _setRepeatOption('Weekly');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Monthly'),
                onTap: () {
                  _setRepeatOption('Monthly');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _setRepeatOption(String option) {
    setState(() {
      repeatOption = option;
    });
  }

  void _saveDataAndNavigateBack() {
    // Add your save logic here

    // Prepare the data to pass back
    Map<String, dynamic> data = {
      'selectedDate': selectedDate,
      'selectedTime': selectedTime,
    };

    // Return the data to the previous screen
    Navigator.pop(context, data);
  }
}
