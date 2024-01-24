import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
// import 'package:gunita20/screens/landingpage_screen.dart';
import 'package:gunita20/screens/settings/account/account.dart';
import 'package:gunita20/screens/settings/account/password.dart';
import 'package:gunita20/screens/signin_screen.dart';

class MySettings extends StatefulWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  final int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xffF2F6FC), Color(0xffDBE9F7).withOpacity(0.8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(20.0),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.white, width: 1.0),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    color: Color(0xff8a8a8a),
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 35.0,
                fontFamily: 'Magdelin',
                fontWeight: FontWeight.bold,
                color: Color(0xff3b0d6b),
              ),
            ),
            SizedBox(height: 5.0),
            _buildContainerWithText(
              'Account',
              fontSize: 23.0,
              color: Color(0xff8a8a8a),
              fontWeight: FontWeight.bold,
              children: [
                _buildListItemWithIcon(
                  text: 'Account Information',
                  icon: Icons.person,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Account()),
                    );
                  },
                  iconColor: Color(0xfffc4530B2), // Set the desired color for this icon
                ),
                _buildListItemWithIcon(
                  text: 'Password and Security',
                  icon: Icons.lock,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Password()),
                    );
                    // Navigate to password and security page
                  },
                  iconColor: Color(0xfffc4530B2), // Set the desired color for this icon
                ),
                _buildListItemWithIcon(
                  text: 'Statistics',
                  icon: Icons.analytics,
                  onPressed: () {
                    // Navigate to statistics page
                  },
                  iconColor: Color(0xfffc4530B2), // Set the desired color for this icon
                ),
              ],
              containerHeight: 140.0,
            ),
            SizedBox(height: 5.0),
            _buildContainerWithText(
              'Preferences',
              fontSize: 23.0,
              color: Color(0xff8a8a8a),
              fontWeight: FontWeight.bold,
              children: [
                _buildListItemWithIcon(
                  text: 'Color Settings',
                  icon: Icons.color_lens_outlined,
                  onPressed: () {
                    // Navigate to color settings page
                  },
                  iconColor: Color(0xfffc4530B2), // Set the desired color for this icon
                ),
                _buildListItemWithIcon(
                  text: 'Language',
                  icon: Icons.language_rounded,
                  onPressed: () {
                    // Navigate to language page
                  },
                  iconColor: Color(0xfffc4530B2), // Set the desired color for this icon
                ),
                _buildListItemWithIcon(
                  text: 'Mobile Notifications',
                  icon: Icons.notification_add_outlined,
                  onPressed: () {
                    // Navigate to statistics page
                  },
                  iconColor: Color(0xfffc4530B2), // Set the desired color for this icon
                ),
              ],
              containerHeight: 140.0,
            ),
            SizedBox(height: 5.0),
            _buildContainerWithText(
              'Feedback',
              fontSize: 23.0,
              color: Color(0xff8a8a8a),
              fontWeight: FontWeight.bold,
              children: [
                _buildListItemWithIcon(
                  text: 'Send Feedback',
                  icon: Icons.feedback_outlined,
                  onPressed: () {
                    // Navigate to account information page
                  },
                  iconColor: Color(0xfffc4530B2), // Set the desired color for this icon
                ),
                _buildListItemWithIcon(
                  text: 'Help',
                  icon: Icons.question_mark,
                  onPressed: () {
                    // Navigate to password and security page
                  },
                  iconColor: Color(0xfffc4530B2), // Set the desired color for this icon
                ),
              ],
              containerHeight: 100.0,
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut().then((value) {
                    print('SIGN OUT SUCCESSFUL!!!!!!!!!!!');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()),
                        (Route<dynamic> route) => false);
                  });
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => LandingPage()),);
                },
                child: Text(
                  "LOGOUT",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Magdelin',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xfffc4530B2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  minimumSize: Size(250.0, 50.0),
                ),
              ),
            ),
            SizedBox(height: 60.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
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
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MySettings()),
              // );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerWithText(
    String text, {
    fontSize = 18.0,
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.normal,
    List<Widget> children = const [],
    double? containerHeight,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: 'Magdelin',
              color: color,
              fontWeight: fontWeight,
            ),
          ),
          Container(
            width: double.infinity,
            height: containerHeight,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItemWithIcon({
  required String text,
  required IconData icon,
  required VoidCallback onPressed,
  Color iconColor = Colors.black, // Added a default color parameter
}) {
  return InkWell(
    onTap: onPressed,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor, // Use the provided color for the icon
          ),
          SizedBox(width: 8.0),
          Text(text),
        ],
      ),
    ),
  );
}


  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30.0,
        color: Color(0xff959595),
      ),
      onPressed: onPressed,
    );
  }
}
