import 'package:flutter/material.dart';
import 'package:gunita20/screens/admin_signin_screen.dart';
import 'package:gunita20/screens/signin_screen.dart';



class LandingPage extends StatelessWidget {
  final double iconSize;

  const LandingPage({Key? key, this.iconSize = 60}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xffe7f9f9),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Choose one',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Magdelin-Bold',
                    fontStyle: FontStyle.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 23),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignInScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ), backgroundColor: const Color(0xffd7caf9),
                    minimumSize: const Size(300, 200),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: const Icon(
                          Icons.person, // Replace with your desired icon
                          size: 120,
                          color: Color(0xff4f22cd),
                        ),
                      ),
                      const Text(
                        'Client',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4f22cd),
                          fontFamily: 'Magdelin-Bold',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AdminSignInScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ), backgroundColor: const Color(0xffd7caf9),
                    minimumSize: const Size(300, 200),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: const Icon(
                          Icons
                              .admin_panel_settings_rounded, // Replace with your desired icon
                          size: 120,
                          color: Color(0xff4f22cd),
                        ),
                      ),
                      const Text(
                        'Administrator',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4f22cd),
                          fontFamily: 'Magdelin-Bold',
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
