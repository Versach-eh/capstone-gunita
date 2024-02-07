import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
// import 'package:gunita20/screens/landingpage_screen.dart';
import 'package:gunita20/screens/settings/account/account.dart';
import 'package:gunita20/screens/settings/account/password.dart';
import 'package:gunita20/screens/settings/account/notification.dart';
import 'package:gunita20/screens/signin_screen.dart';

class MySettings extends StatefulWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: 1.0,
            heightFactor: 0.25, // Set to 0.2 (20% of the screen height)
            child: Image.asset(
              'assets/images/setting.png',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                SizedBox(height: 180.0), // Adjust this height based on your image size
                Text(
                  'Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42.0,
                    fontFamily: 'Magdelin',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff3b0d6b),
                  ),
                ),
            _buildContainerWithText(
              '',
              fontWeight: FontWeight.bold,
              children: [
                _buildListItemWithIcon(
                  text: 'Account Information'
                  ,
                  icon: Icons.person_2_rounded,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Account()),
                    );
                  },
                  iconColor: Color(0xfffc4530B2),
                  containerColor: Color.fromARGB(0, 197, 195, 195) // Set the desired color for this icon
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
                  iconColor: Color(0xfffc4530B2), 
                  containerColor: Color.fromARGB(0, 197, 195, 195)
                  // Set the desired color for this icon
                ),
                _buildListItemWithIcon(
                  text: 'Mobile Notification',
                  icon: Icons.notification_add_outlined,
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Notification()),
                    // );
                  },
                  iconColor: Color(0xfffc4530B2),
                  containerColor: Color.fromARGB(0, 197, 195, 195) // Set the desired color for this icon
                ),
                _buildListItemWithIcon(
                  text: 'Help',
                  icon: Icons.question_mark_rounded,
                  onPressed: () {
                    // Navigate to Help
                  },
                  iconColor: Color(0xfffc4530B2),
                  containerColor: Color.fromARGB(0, 197, 195, 195) // Set the desired color for this icon
                ),
              ],
              containerHeight: 200.0,
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
        ],
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
    fontSize = 2.0,
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
              color: Colors.grey.withOpacity(0.3),
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
  Color iconColor = Colors.black,
  double fontSize = 20.0,
  double iconSize = 24.0,
  Color containerColor = Colors.white, // Set the desired background color
}) {
  return Container(
    decoration: BoxDecoration(
      color: containerColor,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: InkWell(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
            SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Magdelin',
                fontSize: fontSize,
              ),
            ),
          ],
        ),
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
