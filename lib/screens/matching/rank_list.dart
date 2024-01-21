import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";

class RankList extends StatefulWidget {
  const RankList({
    super.key,
    required this.rank,
    required this.duration,
    required this.timestamp,
  });

  final int rank;
  final String duration;
  final Timestamp timestamp;

  @override
  State<RankList> createState() => _RankListState();
}

class _RankListState extends State<RankList> {
  String formatTimestamp(Timestamp timestamp) {
    DateTime now = DateTime.now();
    DateTime dateTime = timestamp.toDate();
    Duration difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).floor();
      return '$years year${years != 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return '$months month${months != 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} day${difference.inDays != 1 ? 's' : ''} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hour${difference.inHours != 1 ? 's' : ''} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minute${difference.inMinutes != 1 ? 's' : ''} ago';
    } else {
      return '${difference.inSeconds} second${difference.inSeconds != 1 ? 's' : ''} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Adjusted alignment
        children: [
          Expanded(
            child: Container(
              width: 75,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              margin: EdgeInsets.only(right: 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      left: 65,
                      child: Text(
                        "${widget.duration}",
                        style: TextStyle(
                            fontFamily: 'kg_inimitable_original',
                            color: Colors.black,
                            fontSize: 22),
                      )),
                  // Circle
                  Positioned(
                    left: 10,
                    child: Stack(
                      children: [
                        Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (widget.rank == 1 ||
                                    widget.rank == 2 ||
                                    widget.rank == 3)
                                ? Color(
                                    0xfffcE17612) // Orange for rank 1, 2, or 3
                                : Colors.grey, // Grey for other ranks
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${widget.rank < 10 ? '0${widget.rank}' : widget.rank}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                              fontFamily: 'kg_inimitable_original',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Container(
              width: 150,
              height: 55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xfffcFFDE59),
              ),
              margin: EdgeInsets.only(left: 0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      formatTimestamp(widget.timestamp),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'purple_smile',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
