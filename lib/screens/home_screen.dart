import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/reminders/category.dart';
import 'package:gunita20/screens/reminders/category_reminder_list.dart';
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  int onThisDayQuantity = 0;
  int onThisWeekQuantity = 0;
  int unresolvedQuantity = 0;
  int completedQuantity = 0;
  List<String> categoryNames = [];
  List<String> categoryColors = [];

  late StreamController<int> onThisDayQuantityController;
  late StreamController<int> onThisWeekQuantityController;
  late StreamController<int> unresolvedQuantityController;
  late StreamController<int> completedQuantityController;

  late Stream<int> onThisDayQuantityStream;
  late Stream<int> onThisWeekQuantityStream;
  late Stream<int> unresolvedQuantityStream;
  late Stream<int> completedQuantityStream;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReminderQuantities().then((value) {
      fetchCategories();
      initializeStreams();
      setState(() {
        isLoading = false;
      });
    });
  }

  void initializeStreams() {
    onThisDayQuantityController = StreamController<int>();
    onThisWeekQuantityController = StreamController<int>();
    unresolvedQuantityController = StreamController<int>();
    completedQuantityController = StreamController<int>();

    onThisDayQuantityStream = onThisDayQuantityController.stream;
    onThisWeekQuantityStream = onThisWeekQuantityController.stream;
    unresolvedQuantityStream = unresolvedQuantityController.stream;
    completedQuantityStream = completedQuantityController.stream;
  }

  Future<void> fetchReminderQuantities() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DateTime today = DateTime.now();
      DateTime endOfWeek = today.add(Duration(days: 6));

      // Fetch on this day quantity
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("reminders")
          .where("date",
              isEqualTo: DateTime(today.year, today.month, today.day))
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        onThisDayQuantityController.add(snapshot.size);
      });

      // Fetch on this week quantity
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("reminders")
          .where("date",
              isGreaterThanOrEqualTo:
                  DateTime(today.year, today.month, today.day),
              isLessThanOrEqualTo: endOfWeek)
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        onThisWeekQuantityController.add(snapshot.size);
      });

      // Fetch unresolved quantity
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("reminders")
          .where("isFinished", isEqualTo: false)
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        unresolvedQuantityController.add(snapshot.size);
      });

      // Fetch completed quantity
      FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("reminders")
          .where("isFinished", isEqualTo: true)
          .snapshots()
          .listen((QuerySnapshot snapshot) {
        completedQuantityController.add(snapshot.size);
      });
    } catch (e) {
      print("Error fetching reminders: $e");
    }
  }

  Future<void> fetchCategories() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot categoriesSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("categories")
          .get();

      List<String> names = [];
      List<String> colors = [];

      categoriesSnapshot.docs.forEach((DocumentSnapshot doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        if (data != null) {
          String name = data["name"];
          String color = data["color"];

          names.add(name);
          colors.add(color);
        }
      });

      setState(() {
        categoryNames = names;
        categoryColors = colors;
      });
    } catch (e) {
      print("Error fetching reminders: $e");
    }
  }

  @override
  void dispose() {
    onThisDayQuantityController.close();
    onThisWeekQuantityController.close();
    unresolvedQuantityController.close();
    completedQuantityController.close();
    super.dispose();
  }

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
              color: quantity > 0
                  ? Color(0xfffc4530B2)
                  : Colors.grey.withOpacity(0.5),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: Text(
                quantity.toString(),
                style: TextStyle(
                  color: quantity > 0 ? Colors.white : Colors.black,
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
      backgroundColor: Color(0xfffcE5F3FF),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await fetchReminderQuantities();
          await fetchCategories();
        },
        strokeWidth: 4,
        child: isLoading
  ? Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircularProgressIndicator(
            strokeWidth: 8,
            strokeCap: StrokeCap.round,
          ),
        )
      ],
    )
  : ListView(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
            children: [
              ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/home.png',
                    width: 350,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 85,
                    left: 15, // Adjust the top position as needed
                    child: Text(
                      'Hello!',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Magdelin',
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    left: 15, // Adjust the bottom position as needed
                    child: Text(
                      'Welcome to GUNITA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily: 'Magdelin',
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
              SizedBox(height: 10),
                Text(
                  'Your Reminders',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Magdelin',
                  ),
                ),
                SizedBox(height: 10),
                isLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 2,
                      child: Center(
                          child: CircularProgressIndicator(
                        strokeWidth: 8,
                      )),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            StreamBuilder<int>(
                              stream: onThisDayQuantityStream,
                              builder: (context, snapshot) {
                                int quantity = snapshot.data ?? 0;

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => TodayScreen()),
                                    );
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          'assets/images/blue.png', // Replace with the actual path to your image asset
                                          width: 170,
                                          height: 150,
                                          fit: BoxFit.cover, // Adjust the fit as needed
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: quantity > 0
                                                ? Color(0xfffc4530B2)
                                                : Colors.white.withOpacity(1.0),
                                            border: Border.all(color: Colors.black, width: 2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              quantity.toString(),
                                              style: TextStyle(
                                                color: quantity > 0 ? Colors.white : Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        left: 28,
                                        child: Text(
                                          'On this day',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Magdelin',
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 10),
                            StreamBuilder<int>(
                              stream: onThisWeekQuantityStream,
                              builder: (context, snapshot) {
                                int quantity = snapshot.data ?? 0;

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => WeekScreen()),
                                    );
                                  },
                                  customBorder: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.asset(
                                          'assets/images/blue.png', // Replace with the actual path to your image asset
                                          width: 170,
                                          height: 150,
                                          fit: BoxFit.cover, // Adjust the fit as needed
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Container(
                                          width: 28,
                                          height: 28,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: quantity > 0
                                                ? Color(0xfffc4530B2)
                                                : Colors.white.withOpacity(1.0),
                                            border: Border.all(color: Colors.black, width: 2),
                                          ),
                                          child: Center(
                                            child: Text(
                                              quantity.toString(),
                                              style: TextStyle(
                                                color: quantity > 0 ? Colors.white : Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        left: 24,
                                        child: Text(
                                          'On this week',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontFamily: 'Magdelin',
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 1), // Adjust the height as needed
              ],
            ),
          ),
        ),
                  categoryNames.isEmpty
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.fromLTRB(30, 30, 28, 10),
                          child: Text(
                            "Your Categories",
                            style: TextStyle(
                                fontFamily: 'Magdelin',
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                  categoryNames.isEmpty
                      ? SizedBox()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: ListView.builder(
                                itemCount: categoryNames.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                CategoryReminderScreen(
                                              category: categoryNames[index],
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            color: Color(int.parse(
                                                categoryColors[index])),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 9),
                                            child: Row(
                                              children: [
                                                Icon(Icons
                                                    .label_outline_rounded, size: 25,),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(categoryNames[index],
                                                 style: TextStyle(
                                                  fontSize: 23,
                                                  color: Colors.black,
                                                  fontFamily: 'Magdelin',
                                                   // Adjust the font size as needed
                                                 ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  );
                                  
                                }),
                          ),
                        ),
                ],
              ),
      ),
      floatingActionButton: Container(
          width: 200, // Adjust the width as needed
          height: 60, // Adjust the height as needed
          child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReminderScreen()),
              );
            },
            label: Text(
              "Add reminder",
              style: TextStyle(
                fontFamily: 'Magdelin',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: Icon(Icons.add_rounded, size: 30,
            ),
            elevation: 0,
            backgroundColor: Color(0xfffc4530B2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22), 
              // Adjust the value as needed
            ),
          ),
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
