import 'package:flutter/material.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  _TodayScreenState createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(.5), // Adjust the color as needed
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30.0, // Adjust the icon color as needed
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Your Reminders On This Day',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Magdelin',
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'No reminders',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Magdelin',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    'Create a reminder and it will appear right here',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Magdelin',
                    ),
                  ),
                  // New Container Widget
                  Container(
                    width: 300, // Adjust the width as needed
                    height: 300, // Adjust the height as needed
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5), // Adjust the color as needed
                      borderRadius: BorderRadius.circular(16.0), // Adjust the border radius as needed
                    ),
                    margin: EdgeInsets.symmetric(vertical: 20), // Adjust the margin as needed
                    padding: EdgeInsets.all(10), // Adjust the padding as needed
                    child: Center(
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TodayScreen(),
  ));
}
