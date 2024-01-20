import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/reminders/category.dart';
import 'package:gunita20/screens/reminders/completed_screen.dart';
import 'package:gunita20/screens/reminders/unresolved_screen.dart';
import 'package:gunita20/screens/reminders/week_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';
import 'package:gunita20/screens/reminders/add_reminder.dart';
import 'package:gunita20/screens/reminders/today_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildAdjustableBox({
    required double width,
    required double height,
    required Color color,
    required BorderRadius borderRadius,
    required BorderSide border,
    Widget? child,
    int quantity = 0, // Default quantity is set to 0
  }) {
    return Stack(
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            border: Border.all(color: border.color, width: border.width),
          ),
          child: child,
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.5),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: Text(
                quantity.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: Color.fromARGB(255, 133, 133, 133),
      ),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Column(
                children: [
                  Text(
                    'Your Reminders',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36.0,
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
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => TodayScreen()),
                              );
                            },
                            child: _buildAdjustableBox(
                              width: 170,
                              height: 150,
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                              border: BorderSide(color: Colors.white, width: 2),
                              child: Center(
                                child: Text(
                                  'On this day',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Magdelin',
                                  ),
                                ),
                              ),
                              quantity: 0,
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WeekScreen()),
                              );
                            },
                            child: _buildAdjustableBox(
                              width: 170,
                              height: 150,
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                              border: BorderSide(color: Colors.white, width: 2),
                              child: Center(
                                child: Text(
                                  'On this week',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Magdelin',
                                  ),
                                ),
                              ),
                              quantity: 0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(  
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => UnresolvedScreen()),
                              );
                            },
                            child: _buildAdjustableBox(
                              width: 170,
                              height: 150,
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                              border: BorderSide(color: Colors.white, width: 2),
                              child: Center(
                                child: Text(
                                  'Unresolved',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Magdelin',
                                  ),
                                ),
                              ),
                              quantity: 0,
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => CompletedScreen()),
                              );
                            },
                            child: _buildAdjustableBox(
                              width: 170,
                              height: 150,
                              color: Colors.grey.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(15),
                              border: BorderSide(color: Colors.white, width: 2),
                              child: Center(
                                child: Text(
                                  'Completed',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Magdelin',
                                  ),
                                ),
                              ),
                              quantity: 0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 20,
            child: Container(
              width: 180,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReminderScreen()),
                  );
                },
                child: Text(
                  'Add reminder',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavigationButton(Icons.home, () {}),
            _buildNavigationButton(Icons.games, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GameLibrary()),
              );
            }),
            _buildNavigationButton(Icons.photo_album, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Album()),
              );
            }),
            _buildNavigationButton(Icons.settings, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MySettings()),
              );
            }),
          ],
        ),
      ),
    );
  }
}
