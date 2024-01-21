import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/jigsaw/easy_scoreboard.dart';
import 'package:gunita20/screens/jigsaw/hard_scoreboard.dart';
import 'package:gunita20/services/firebase_service.dart';
import 'package:gunita20/ui/widgets/rank_list.dart';

class MediumScoreboardScreen extends StatefulWidget {
  const MediumScoreboardScreen({Key? key}) : super(key: key);

  @override
  _MediumScoreboardScreenState createState() => _MediumScoreboardScreenState();
}

class _MediumScoreboardScreenState extends State<MediumScoreboardScreen> {
  List<int> topDurations = [];
  List<Timestamp> topTimestamps = [];

  @override
  void initState() {
    getAllPlaysData();
    super.initState();
  }

  Future<void> getAllPlaysData() async {
    try {
      final String userId = FirebaseService().user.uid;

      CollectionReference ref = FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .collection("games")
          .doc("jigsaw")
          .collection("plays");

      QuerySnapshot playsSnapshot = await ref.get();

      List<int> durations = [];
      List<Timestamp> timestamps = [];

      playsSnapshot.docs.forEach((DocumentSnapshot doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

        if (data != null &&
            data.containsKey("duration") &&
            data.containsKey("difficulty") &&
            data.containsKey("gameFinishedAt") &&
            data["difficulty"] == 1) {
          int duration = data["duration"] as int;
          durations.add(duration);
          timestamps.add(data["gameFinishedAt"] as Timestamp);
        }
      });

      // Sort the lists in descending order
      durations.sort((a, b) => a.compareTo(b));
      timestamps = List.from(timestamps)..sort((a, b) => b.compareTo(a));

      setState(() {
        topDurations = durations;
        topTimestamps = timestamps;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  String formatDuration(int seconds) {
    Duration duration = Duration(seconds: seconds);

    String twoDigits(int n) {
      if (n >= 10) {
        return "$n";
      } else {
        return "0$n";
      }
    }

    String hours =
        duration.inHours > 0 ? '${twoDigits(duration.inHours)}:' : '';
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String secondsStr = twoDigits(duration.inSeconds.remainder(60));

    return '$hours$minutes:$secondsStr';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/pair_play.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 16.0),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 30.0, top: 35.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xfffcE17612),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 32.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Stack(
                children: [
                  Text(
                    'SCOREBOARD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42.0,
                      fontFamily: 'kg_inimitable_original',
                      foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..color = Colors.black
                        ..strokeWidth = 4,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(1.0),
                          offset: Offset(0, 6),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'SCOREBOARD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 42.0,
                      fontFamily: 'kg_inimitable_original',
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(0, 0),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xfffcE17612).withOpacity(1.0),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 6),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20), // Rounded sides
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EasyScoreboardScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(165, 45),
                      primary: Color(0xfffcE17612),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "Easy",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.white,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xfffcE17612).withOpacity(1.0),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 6),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20), // Rounded sides
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => CategoryMatchingMenuScreen(),
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(165, 45),
                      primary: Color(0xfffcFFDE59),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    child: Text(
                      "Medium",
                      style: TextStyle(
                        fontFamily: 'purple_smile',
                        color: Colors.black,
                        fontSize: 28.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xfffcE17612).withOpacity(1.0),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 6),
                  ),
                ],
                borderRadius: BorderRadius.circular(20), // Rounded sides
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HardScoreboardScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(165, 45),
                  primary: Color(0xfffcE17612),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Colors.white,
                      width: 3.0,
                    ),
                  ),
                ),
                child: Text(
                  "Hard",
                  style: TextStyle(
                    fontFamily: 'purple_smile',
                    color: Colors.white,
                    fontSize: 28.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50.0),
            Expanded(
              child: topDurations.length == 0
                  ? Center(
                      child: Stack(
                        children: [
                          Text(
                            'No scores yet. Start playing to compare your scores here.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'purple_smile',
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..color = Colors.black
                                ..strokeWidth = 3,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(1.0),
                                  offset: Offset(0, 3),
                                  blurRadius: 3,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'No scores yet. Start playing to compare your scores here.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: 'purple_smile',
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.5),
                                  offset: Offset(0, 0),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount:
                          topDurations.length > 10 ? 10 : topDurations.length,
                      itemBuilder: (BuildContext context, int index) {
                        int rank = index + 1;
                        String duration = formatDuration(topDurations[index]);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: RankList(
                            rank: rank,
                            duration: duration,
                            timestamp: topTimestamps[index],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
