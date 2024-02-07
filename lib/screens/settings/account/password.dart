import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/settings/account/edit_password.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';
import 'edit_bd.dart';

class Password extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!;

  Password({Key? key}) : super(key: key);

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
          padding: const EdgeInsets.all(20),
          children: [
           
            const SizedBox(height: 100),
            const Text(
              'Password and Security',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: Color(0xff3b0d6b),
              ),
            ),
            const SizedBox(height: 5),
            _buildContainerWithText(
              text: '',
              children: [
                _buildListItemWithIcon(
                  text: 'Change Password',
                  icon: Icons.person,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const EditPassword()),
                    );
                  },
                  fontSize: 18,
                  textColor: Colors.black,
                ),
                _buildListItemWithIcon(
                  text: 'Two-factor authentication',
                  icon: Icons.password_outlined,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BirthdayScreen(userId: user.uid)),
                    );
                  },
                  fontSize: 18,
                  textColor: Colors.black,
                ),
              ],
              containerHeight: 115,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavigationButton(Icons.home, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            }),
            _buildNavigationButton(Icons.games, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GameLibrary()),
              );
            }),
            _buildNavigationButton(Icons.photo_album, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Album()),
              );
            }),
            _buildNavigationButton(Icons.settings, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MySettings()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildContainerWithText({
    required String text,
    double fontSize = 18,
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
              color: color,
              fontWeight: fontWeight,
            ),
          ),
          Container(
          width: double.infinity,
          height: containerHeight,
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all( // Add this line to set borderSide
              color: Color(0xfffc4530B2), // Set your desired border color
              width: 1.0, // Set your desired border width
            ),
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
    double fontSize = 18,
    Color textColor = Colors.black,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Color(0xfffc4530B2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
    return IconButton(
      icon: Icon(
        icon,
        size: 30,
        color: const Color(0xff959595),
      ),
      onPressed: onPressed,
    );
  }
}
