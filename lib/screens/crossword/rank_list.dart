import "package:flutter/material.dart";

class RankList extends StatefulWidget {
  const RankList({
    super.key,
    required this.rank,
    required this.duration,
  });

  final int rank;
  final String duration;

  @override
  State<RankList> createState() => _RankListState();
}

class _RankListState extends State<RankList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Adjusted alignment
        children: [
          Expanded(
            child: Container(
              width: 220,
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
          widget.rank <= 3
              ? Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Container(
                    width: 120,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xfffcFFDE59),
                    ),
                    margin: EdgeInsets.only(left: 0),
                    child: Stack(
                      children: [
                        if (widget.rank == 1)
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/gold_scoreboard.png',
                              fit: BoxFit.contain,
                            ),
                          )
                        else if (widget.rank == 2)
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/silver_scoreboard.png',
                              fit: BoxFit.contain,
                            ),
                          )
                        else if (widget.rank == 3)
                          Positioned.fill(
                            child: Image.asset(
                              'assets/images/bronze_scoreboard.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
