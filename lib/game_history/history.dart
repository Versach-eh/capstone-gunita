import 'package:flutter/material.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';

class GameHistory extends StatefulWidget {
  const GameHistory({Key? key}) : super(key: key);

  @override
  _GameHistoryState createState() => _GameHistoryState();
}

class _GameHistoryState extends State<GameHistory> {
  double containerHeight1 = 130.0;
  double containerHeight2 = 130.0;
  double containerHeight3 = 130.0; // Initial height of the container

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffcF0F4FC),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section
                Container(
                  padding: const EdgeInsets.all(15),
                  color: Color(0xfffcF0F4FC),
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      Text(
                        'Your Game History',
                        style: TextStyle(
                          fontSize: 35,
                          fontFamily: 'Magdelin',
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      
                      Positioned(
                        // top: 20,
                        // right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _buildElevatedButton(),
                            SizedBox(height: 1),
                            _buildGameContainer('Mindful Merge', containerHeight1, 1),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildGameContainer('Word Wander', containerHeight2, 2),
                      SizedBox(height: 10),
                      _buildGameContainer('Pair Play', containerHeight3, 3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        color: Colors.grey.withOpacity(0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavigationButton(Icons.home, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }),
            _buildNavigationButton(Icons.games, () {
              // Handle the game library button click
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

 Widget _buildElevatedButton() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end, // Align children to the end
    children: [
      Container( // Wrap PopupMenuButton with a Container
        alignment: Alignment.centerRight,
        child: Builder(
          builder: (context) => PopupMenuButton<String>(
            onSelected: (value) {
              // Handle selected option
              // You can perform sorting logic here based on the selected value ('Daily', 'Weekly', 'Monthly')
              // For now, let's just print the selected value.
              print('Selected option: $value');
            },
            itemBuilder: (BuildContext context) {
              return ['Daily', 'Weekly', 'Monthly'].map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
            child: ElevatedButton(
              onPressed: () {
                // Handle elevated button press
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xffc4530B2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              child: Text(
                'Sort by',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Magdelin',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}


  Widget _buildGameContainer(String gameTitle, double containerHeight, int containerNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              gameTitle,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xfffc4530B2),
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: containerHeight,
          width: 350,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
            color: Color(0xfffcF0F4FC),
            border: Border.all(
              color: Color(0xfffc4530B2),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildButton('EASY', buttonWidth: 100.0, buttonHeight: 40.0),
                  _buildButton('MEDIUM', buttonWidth: 100.0, buttonHeight: 40.0),
                  _buildButton('HARD', buttonWidth: 100.0, buttonHeight: 40.0),
                ],
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(
                    Icons.expand_more,
                    size: 30,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    // Handle the expand icon press
                    setState(() {
                      if (containerNumber == 1) {
                        containerHeight1 = containerHeight1 == 130.0 ? 200.0 : 130.0;
                      } else if (containerNumber == 2) {
                        containerHeight2 = containerHeight2 == 130.0 ? 200.0 : 130.0;
                      } else if (containerNumber == 3) {
                        containerHeight3 = containerHeight3 == 130.0 ? 200.0 : 130.0;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String label, {double buttonWidth = 100.0, double buttonHeight = 50.0}) {
    return Container(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
        },
        style: ElevatedButton.styleFrom(
          primary: Color(0xfffc4530B2), // Change the color as needed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Adjust the border radius as needed
          ),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 35,
        color: Color.fromARGB(255, 109, 109, 109),
      ),
      onPressed: onPressed,
    );
  }
}
