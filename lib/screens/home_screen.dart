import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  int onThisDayQuantity = 0;
  int onThisWeekQuantity = 0;
  int unresolvedQuantity = 0;
  int completedQuantity = 0;

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
                  ? Colors.deepPurple
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
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          await fetchReminderQuantities();
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
                          SizedBox(height: 75),
                          isLoading
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    strokeWidth: 8,
                                  )),
                                )
                              : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        StreamBuilder<int>(
                                            stream: onThisDayQuantityStream,
                                            builder: (context, snapshot) {
                                              int quantity = snapshot.data ?? 0;

                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TodayScreen()),
                                                  );
                                                },
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15))),
                                                child: _buildAdjustableBox(
                                                  width: 170,
                                                  height: 150,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: BorderSide(
                                                      color: Colors.white,
                                                      width: 2),
                                                  child: Center(
                                                    child: Text(
                                                      'On this day',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Magdelin',
                                                      ),
                                                    ),
                                                  ),
                                                  quantity: quantity,
                                                ),
                                              );
                                            }),
                                        SizedBox(height: 10),
                                        StreamBuilder<int>(
                                            stream: onThisWeekQuantityStream,
                                            builder: (context, snapshot) {
                                              int quantity = snapshot.data ?? 0;

                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            WeekScreen()),
                                                  );
                                                },
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15))),
                                                child: _buildAdjustableBox(
                                                  width: 170,
                                                  height: 150,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: BorderSide(
                                                      color: Colors.white,
                                                      width: 2),
                                                  child: Center(
                                                    child: Text(
                                                      'On this week',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Magdelin',
                                                      ),
                                                    ),
                                                  ),
                                                  quantity: quantity,
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        StreamBuilder<int>(
                                            stream: unresolvedQuantityStream,
                                            builder: (context, snapshot) {
                                              int quantity = snapshot.data ?? 0;

                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UnresolvedScreen()),
                                                  );
                                                },
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15))),
                                                child: _buildAdjustableBox(
                                                  width: 170,
                                                  height: 150,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: BorderSide(
                                                      color: Colors.white,
                                                      width: 2),
                                                  child: Center(
                                                    child: Text(
                                                      'Unresolved',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Magdelin',
                                                      ),
                                                    ),
                                                  ),
                                                  quantity: quantity,
                                                ),
                                              );
                                            }),
                                        SizedBox(height: 10),
                                        StreamBuilder<int>(
                                            stream: completedQuantityStream,
                                            builder: (context, snapshot) {
                                              int quantity = snapshot.data ?? 0;

                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            CompletedScreen()),
                                                  );
                                                },
                                                customBorder:
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    15))),
                                                child: _buildAdjustableBox(
                                                  width: 170,
                                                  height: 150,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: BorderSide(
                                                      color: Colors.white,
                                                      width: 2),
                                                  child: Center(
                                                    child: Text(
                                                      'Completed',
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Magdelin',
                                                      ),
                                                    ),
                                                  ),
                                                  quantity: quantity,
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                  // Positioned(
                  //   bottom: 30,
                  //   right: 20,
                  //   child: Container(
                  //     width: 180,
                  //     height: 60,
                  //     decoration: BoxDecoration(
                  //       color: Colors.grey.withOpacity(0.5),
                  //       borderRadius: BorderRadius.circular(8),
                  //     ),
                  //     child: TextButton(
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => ReminderScreen()),
                  //         );
                  //       },
                  //       child: Text(
                  //         'Add reminder',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           color: Colors.black,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
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
              fontWeight: FontWeight.bold),
        ),
        icon: Icon(Icons.add_rounded),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
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
