import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/reminders/add_reminder.dart';
import 'package:intl/intl.dart';

class UnresolvedScreen extends StatefulWidget {
  const UnresolvedScreen({Key? key}) : super(key: key);

  @override
  _UnresolvedScreenState createState() => _UnresolvedScreenState();
}

class _UnresolvedScreenState extends State<UnresolvedScreen> {
  List<String> unresolvedSchedules = [];
  List<DateTime> unresolvedDates = [];
  List<String> unresolvedTimes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchReminders().then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> fetchReminders() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;

      QuerySnapshot remindersSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("reminders")
          .where("isFinished", isEqualTo: false)
          .get();

      List<String> unresolved = [];
      List<DateTime> unresolvedDateList = [];
      List<String> unresolvedTimesList = [];

      remindersSnapshot.docs.forEach((DocumentSnapshot doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey("isFinished")) {
          String title = data["title"];

          Timestamp timestamp = data["date"];
          DateTime date = timestamp.toDate();

          unresolved.add(title);
          unresolvedDateList.add(date);
          unresolvedTimesList.add(data["time"]);
        }
      });

      setState(() {
        unresolvedSchedules = unresolved;
        unresolvedDates = unresolvedDateList;
        unresolvedTimes = unresolvedTimesList;
      });
    } catch (e) {
      print("Error fetching reminders: $e");
    }
  }

  Future<void> updateReminderStatus(String title, bool isFinished) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot remindersSnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("reminders")
          .where("title", isEqualTo: title)
          .get();

      if (remindersSnapshot.docs.isNotEmpty) {
        DocumentSnapshot reminderDoc = remindersSnapshot.docs.first;
        String reminderId = reminderDoc.id;

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userId)
            .collection("reminders")
            .doc(reminderId)
            .update({"isFinished": isFinished});
      }
    } catch (e) {
      print("Error updating reminder status: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                decoration: ShapeDecoration(
                    shape: CircleBorder(), color: Colors.deepPurple),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: CircleBorder(),
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.0,
                      ),
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
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'Your Unresolved Reminders',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Magdelin',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Swipe each item to the left to delete',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'Magdelin',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: !isLoading
                        ? unresolvedSchedules.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'No reminders',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Magdelin',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      'Create a reminder and it will appear right here',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        fontFamily: 'Magdelin',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ListView(
                                  children: [
                                    for (int i = 0;
                                        i < unresolvedSchedules.length;
                                        i++)
                                      _buildDismissibleItem(
                                          unresolvedSchedules[i],
                                          false,
                                          unresolvedDates[i],
                                          unresolvedTimes[
                                              i] // Pass unresolved date
                                          ),
                                  ],
                                ),
                              )
                        : Center(
                            child: CircularProgressIndicator(
                              strokeCap: StrokeCap.round,
                              strokeWidth: 8,
                            ),
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

  Widget _buildDismissibleItem(
      String title, bool isCompleted, DateTime date, String time) {
    return Dismissible(
      key: Key(title),
      background: _buildDismissBackground(isCompleted, true),
      secondaryBackground: _buildDismissBackground(isCompleted, false),
      onDismissed: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await _deleteReminder(title, date, time);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$title deleted'),
          ));
        } else if (direction == DismissDirection.endToStart) {
          // TODO: Handle edit
        }
      },
      child: _buildCheckboxListTile(title, isCompleted, date, time),
    );
  }

  Widget _buildDismissBackground(bool isCompleted, bool isStart) {
    return Container(
      color: isStart ? Colors.red : Colors.green,
      alignment: isStart ? Alignment.centerLeft : Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(
            left: isStart ? 12.0 : 0, right: isStart ? 0 : 12.0),
        child: Icon(
          isStart ? Icons.delete : Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCheckboxListTile(
      String title, bool isCompleted, DateTime date, String time) {
    String formattedDate = DateFormat.yMd().format(date);

    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: isCompleted
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
              Text(
                "$formattedDate $time",
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                // TODO: Add edit page
              },
              icon: Icon(Icons.edit_rounded))
        ],
      ),
      value: isCompleted,
      checkboxShape: CircleBorder(),
      shape: Border(
        bottom: BorderSide(
          width: 1,
        ),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (bool? value) async {
        if (value != null) {
          if (isCompleted) {
            _moveToUnresolved(title, date, time);
          } else {
            _moveToCompleted(title, date, time);
          }
          await updateReminderStatus(title, !isCompleted);
        }
      },
    );
  }

  Future<void> _deleteReminder(String title, DateTime date, String time) async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userId)
        .collection("reminders")
        .where("title", isEqualTo: title)
        .get()
        .then((QuerySnapshot remindersSnapshot) {
      if (remindersSnapshot.docs.isNotEmpty) {
        DocumentSnapshot reminderDoc = remindersSnapshot.docs.first;
        String reminderId = reminderDoc.id;
        FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("reminders")
            .doc(reminderId)
            .delete();
      }
    });
    setState(() {
      unresolvedSchedules.remove(title);
      unresolvedDates.remove(date);
      unresolvedTimes.remove(time);
    });
  }

  void _moveToUnresolved(String title, DateTime date, String time) {
    setState(() {
      unresolvedSchedules.add(title);
      unresolvedDates.add(date);
      unresolvedTimes.add(time);
    });
  }

  void _moveToCompleted(String title, DateTime date, String time) {
    setState(() {
      unresolvedSchedules.remove(title);
      unresolvedDates.remove(date);
      unresolvedTimes.remove(time);
    });
  }
}
