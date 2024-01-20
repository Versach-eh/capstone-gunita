import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/signin_screen.dart';

class LandingPage2 extends StatefulWidget {
  const LandingPage2({super.key});

  @override
  _LandingPage2State createState() => _LandingPage2State();
}

class _LandingPage2State extends State<LandingPage2>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isMenuOpen = !_isMenuOpen;
      if (_isMenuOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _navigateToGameLibrary() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const GameLibrary()),
    );
  }

  void _logout() {
    // Implement logout functionality here
    FirebaseAuth.instance.signOut().then((value) {
      print("signed out");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignInScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xff6932ca),
      body: Stack(
        children: [
          if (_isMenuOpen)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              child: GestureDetector(
                onTap: _toggleMenu,
                child: Container(
                  width: screenWidth * 0.6,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: _isMenuOpen ? 80 : 0,
            left: _isMenuOpen ? screenWidth * 0.6 : 0,
            right: _isMenuOpen ? -screenWidth * 0.4 : 0,
            bottom: _isMenuOpen ? 80 : 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_isMenuOpen ? 30 : 0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                  ),
                  Center(
                    child: Container(
                      width: screenWidth,
                      padding: const EdgeInsets.all(20),
                      color: const Color(0xff690e79),
                      child: const Text(
                        'Hello Teresa',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/gunita.png', // Replace with actual image path
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 10),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Teresa',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Birthdate: September 1, 1990', // Replace with actual birthdate
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'How are you feeling today?',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          color: Colors.lightBlue, // Set the light blue color
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Handle emoji selection
                                },
                                icon: const Icon(
                                  Icons.sentiment_very_satisfied,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Handle emoji selection
                                },
                                icon: const Icon(
                                  Icons.sentiment_satisfied,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Handle emoji selection
                                },
                                icon: const Icon(
                                  Icons.sentiment_neutral,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Handle emoji selection
                                },
                                icon: const Icon(
                                  Icons.sentiment_dissatisfied,
                                  size: 30,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  // Handle emoji selection
                                },
                                icon: const Icon(
                                  Icons.sentiment_very_dissatisfied,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: _navigateToGameLibrary,
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  const Size(300, 100), backgroundColor: const Color(
                                  0xff3a0697), // Set the button color to dark purple
                            ),
                            child: const Text(
                              'Play Games',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Poppins', // Set the font family
                                fontStyle:
                                    FontStyle.normal, // Set the font style
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // Handle Recall Memories option
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize:
                                  const Size(300, 100), backgroundColor: const Color(
                                  0xff3a0697), // Set the button color to dark purple
                            ),
                            child: const Text(
                              'Recall Memories',
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: 'Poppins', // Set the font family
                                fontStyle:
                                    FontStyle.normal, // Set the font style
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isMenuOpen)
            Positioned(
              top: 80,
              left: screenWidth * 0.05,
              right: -screenWidth * 0.2,
              bottom: 80,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(Icons.language),
                      title: const Text('Language'),
                      onTap: () {
                        // Handle Language option
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.color_lens),
                      title: const Text('Color Settings'),
                      onTap: () {
                        // Handle Color Settings option
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.notifications),
                      title: const Text('Mobile Notifications'),
                      onTap: () {
                        // Handle Mobile Notifications option
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.insert_chart),
                      title: const Text('Statistics'),
                      onTap: () {
                        // Handle Statistics option
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Logout'),
                      onTap: () {
                        // Handle Logout option
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white),
                onPressed: () {
                  // Handle home button press
                },
              ),
              IconButton(
                icon: const Icon(Icons.photo_library, color: Colors.white),
                onPressed: () {
                  // Handle gallery button press
                },
              ),
              IconButton(
                icon: const Icon(Icons.games, color: Colors.white),
                onPressed: _navigateToGameLibrary,
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: _toggleMenu,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
