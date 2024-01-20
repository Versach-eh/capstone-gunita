import 'package:flutter/material.dart';
import 'package:gunita20/screens/home_screen.dart';

class Congratulations extends StatelessWidget {
  const Congratulations({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe7f9f9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/congrats.png',
              width: 200,
              height: 200,
            ),
            const Text(
              'Congratulations!',
              style: TextStyle(
                fontSize: 31,
                fontWeight: FontWeight.bold,
                color: Color(0xff4f22cd), // Set the text color to dark purple
                fontFamily: 'Poppins', // Set the font family
                fontStyle: FontStyle.normal, // Set the font style
              ),
            ),
            const Text(
              'Your account has been',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000), // Set the text color to white
              ),
            ),
            const Text(
              'successfully created',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000), // Set the text color to white
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    const HomeScreen()), (Route<dynamic> route) => false);
              },
              child: const Text(
                'LETS GO',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xfffcfcfc),
                  fontWeight: FontWeight.bold, // Set the font color to black
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4f22cd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(300, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
