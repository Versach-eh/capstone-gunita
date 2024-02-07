import 'package:flutter/material.dart';
import 'package:gunita20/screens/signin_screen.dart';

class CoverPage extends StatelessWidget {
  const CoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3D1372),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/G.png',
                  width: 180,
                  height: 200,
                ),
                const Text(
                  'unita',
                  style: TextStyle(
                    fontSize: 85,
                    fontWeight: FontWeight.normal,
                    color: Color(0xfffcfbfd),
                    fontFamily: 'MichlandScript',
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ],
            ),
            const Text(
              'Your all-in one app for dementia care',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xfff9f6f9),
                fontFamily: 'Magdelin',
                fontStyle: FontStyle.normal,
              ),
            ),
            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff3D1372),
                  fontFamily: 'Magdelin-Bold',
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(200, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
