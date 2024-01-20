  // Proper congratulation and paused timer when puzzle complete (prints accurate time & format)
  // modern looking timer
  // dark background
  // working pause timer
  // working restart button
  // with confirmation dialogues
  // no overflowing

  // non functional pause menu
  // no congratulations and time saving

  // keywords:
  // touchdown = correct piece


  // ignore_for_file: prefer_const_constructors, prefer_conditional_assignment, unnecessary_new, curly_braces_in_flow_control_structures

  import 'dart:io';
  import 'dart:ui';
  import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/rendering.dart';
import 'package:gunita20/screens/jigsaw/game_difficulty.dart';
import 'package:gunita20/screens/jigsaw/menu.dart';
import 'package:gunita20/services/firebase_service.dart';
  import 'package:image/image.dart' as ui;
  import 'dart:math' as math;
  import 'package:audioplayers/audioplayers.dart';
  import 'package:image_picker/image_picker.dart';
  import 'dart:async';
  





  class PuzzleWidgetHard extends StatefulWidget {
    PuzzleWidgetHard({Key? key}) : super(key: key);

    @override
    _PuzzleWidgetHardState createState() => _PuzzleWidgetHardState();
  }



  class _PuzzleWidgetHardState extends State<PuzzleWidgetHard> {
  //   final User? currentUser;
  // final Difficulty difficulty;
        final FirebaseService firebaseService = FirebaseService();
        // String difficultyId = "easy";


      int _timerValue = 0; // Add this line



    File? _selectedImage; // Declare _selectedImage here


    bool _isPuzzleComplete  = false;
    bool _isJigsawStarted = false;
    // int _timerSeconds = 0;
    // DateTime? _puzzleStartTime;
    bool _isGamePaused = false; // Track whether the game is paused
    bool _showPauseMenu = false;

    bool _showRestartDialog = false;
    bool _showQuitDialog = false;

    late Timer _timer;

    GlobalKey<_JigsawWidgetState> jigKey = new GlobalKey<_JigsawWidgetState>();
    


    AudioCache audioCache = AudioCache();

    bool getIsJigsawStarted() {
    return _isJigsawStarted;
    }

    void _showRestartConfirmation() {
  setState(() {
    _showRestartDialog = true;
  });
}

    void _showQuitConfirmation() {
  setState(() {
    _showQuitDialog = true;
  });
}


    // method for upload image button

    Future<void> _pickImage() async {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
          jigKey.currentState?.setNewImage(_selectedImage);

        });
      }

    }
    String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedTime =
        '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  Future<void> _recordScore() async {
    // String uniqueId = Uuid().v4(); // Generate a unique random string
    String difficultyId = 'easy';

      final Difficulty difficulty = Difficulty(id: difficultyId, scoresTimerValues: [] , );
      firebaseService.addScore(difficulty);

      // await FirebaseFirestore.instance.collection('Users/${firebaseService.user.uid}/Scoreboard/Jigsaw').doc('easy').update({
      //   'timerValues': FieldValue.arrayUnion([_timerValue]),
      // });

      

  }

  void _showImagePreview(BuildContext context, File imageFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(imageFile),
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
  




  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          color: Color.fromARGB(255, 59, 58, 61),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(height: 37),
                    if (_isJigsawStarted)
                      Container(
                        alignment: Alignment.center,
                        child: TimerWidget(
                          isGamePaused: _isGamePaused, 
                          isPuzzleComplete: _isPuzzleComplete, 
                          onTimerUpdate: (timerValue) { 
                            setState(() {
                              _timerValue = timerValue;
                            });
                            _recordScore(); // failed (create a doc for every)
                          },
                          ),
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: JigsawWidget(
                          callbackFinish: () {
                        setState(() {
                          _isPuzzleComplete = true;
                           _isGamePaused = true;
                          
                          
                          
                        });
                        Future.delayed(Duration(seconds: 1), () {
                          setState(() {
                            _isPuzzleComplete = false;
                          });
                        });
                      },
                      callbackSuccess: () {
                        print("callbackSuccess"); 
                      },
                      key: jigKey,
                      child: _selectedImage != null
                          ? Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Image.file(
                                _selectedImage!,
                                fit: BoxFit.contain,
                              ),
                            )
                          : Image.asset(
          'assets/images/kris.jpg',
          fit: BoxFit.cover,
        ),
                        ),
                      ),
                    ),
                    if (!_isJigsawStarted)
                      Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade800.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                            await jigKey.currentState?.generaJigsawCropImage();
                            setState(() {
                              _isJigsawStarted = true;
                            });
                          },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: Color(0xfffc36C655),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Use default photo",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),


                        SizedBox(height: 10),


                        Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade800.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                    ),
                    child: ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: Color(0xfffc36C655),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Upload a picture",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),


                        SizedBox(height: 10),


                        Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 75, 78, 75).withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                            await jigKey.currentState?.generaJigsawCropImage();
                            setState(() {
                              _isJigsawStarted = true;
                            });
                          },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: Color(0xfffc36C655),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Let's start!",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),

                  
                      ],
                    ),
                      ),
                      
                    // AnimatedOpacity(
                    //   opacity: _isPuzzleComplete ? 1.0 : 0.0,
                    //   duration: Duration(milliseconds: 500),
                    //   child: Text(
                    //     "Congratulations, Puzzle Done!",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    
                  ],
                ),

                AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: _isGamePaused
                ? MediaQuery.of(context).size.height / 4
                : -MediaQuery.of(context).size.height,
            left: MediaQuery.of(context).size.width / 9,
            right: MediaQuery.of(context).size.width / 9,
            child: _isGamePaused
                ? Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 249, 227, 1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color.fromRGBO(225, 118, 18, 1),
                        width: 8.0,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Congratulations!\nYour Score is\n${_formatTime(_timerValue)}",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'purple_smile',
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),



                        SizedBox(height: 5),



                        Container(
                          // ... (other code for the "No" button)
                          decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade800.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                          ),
                       child: ElevatedButton(
                      onPressed: () {
                            setState(() {
                              _isGamePaused = false;
                            });
                            jigKey.currentState?.resetJigsaw();
                            setState(() {
                              _isJigsawStarted = false;
                            });
                            setState(() {
                              _showRestartDialog = false;
                            });
                          },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: Color(0xfffc36C655),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Play again",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                        ),



                        SizedBox(height: 15),



                        Container(
                          // ... (other code for the "No" button)
                          decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 170, 21, 21).withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                          ),
                       child: ElevatedButton(
                      onPressed: () {
                            setState(() {
                            // _showRestartDialog = false;
                            // apply quit page nav to start menu here
                            
                          });
                          },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: const Color.fromRGBO(214, 49, 49, 1), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Quit",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(), // Empty SizedBox when not shown
          ),


                // EDIT THE PAUSE MENU HERE
                AnimatedPositioned(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: _showPauseMenu ? MediaQuery.of(context).size.height / 4 : -MediaQuery.of(context).size.height,
                  left: MediaQuery.of(context).size.width / 9,
                  right: MediaQuery.of(context).size.width / 9,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 249, 227,1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color.fromRGBO(225, 118, 18, 1), 
                        width: 8.0, 
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "The game is paused,\nWould you like to...",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'purple_smile', 
                            fontSize: 24, 
                          ),
                          textAlign: TextAlign.center,
                        ),



                        SizedBox(height: 5),

                      

                        Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade800.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                            setState(() {
                              _isGamePaused = false;
                              _showPauseMenu = false; 
                            });
                          },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: Color(0xfffc36C655),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    ),



                        SizedBox(height: 15),



                        Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade800.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                    ),
                    child: ElevatedButton(
                      onPressed: _showRestartConfirmation,

                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: Color(0xfffc36C655),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Restart",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                        ),



                        SizedBox(height: 15),

                        


                        Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 170, 21, 21).withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                    ),
                    child: ElevatedButton(
                      onPressed: _showQuitConfirmation,
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: const Color.fromRGBO(214, 49, 49, 1), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Quit",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                        ),



                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: _isGamePaused
                ? MediaQuery.of(context).size.height / 4
                : -MediaQuery.of(context).size.height,
            left: MediaQuery.of(context).size.width / 9,
            right: MediaQuery.of(context).size.width / 9,
            child: _showRestartDialog
                ? Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 249, 227, 1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color.fromRGBO(225, 118, 18, 1),
                        width: 8.0,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Are you sure you want to restart? You might not want to lose your progress.",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'purple_smile',
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),



                        SizedBox(height: 5),



                        Container(
                          // ... (other code for the "No" button)
                          decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade800.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                          ),
                       child: ElevatedButton(
                      onPressed: () {
                            // setState(() {
                            //   _isGamePaused = false; 
                            // });
                            setState(() {
                            _showRestartDialog = false;
                          });
                          },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: Color(0xfffc36C655),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                        ),



                        SizedBox(height: 15),



                        Container(
                          // ... (other code for the "No" button)
                          decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 170, 21, 21).withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                          ),
                       child: ElevatedButton(
                      onPressed: () {
                            setState(() {
                              _isGamePaused = false;
                              _showPauseMenu = false;
                            });
                            jigKey.currentState?.resetJigsaw();
                            setState(() {
                              _isJigsawStarted = false;
                            });
                            setState(() {
                              _showRestartDialog = false;
                            });
                          },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: const Color.fromRGBO(214, 49, 49, 1), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(), // Empty SizedBox when not shown
          ),
          
          // part 2

                AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: _isGamePaused
                ? MediaQuery.of(context).size.height / 4
                : -MediaQuery.of(context).size.height,
            left: MediaQuery.of(context).size.width / 9,
            right: MediaQuery.of(context).size.width / 9,
            child: _showQuitDialog
                ? Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 249, 227, 1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color.fromRGBO(225, 118, 18, 1),
                        width: 8.0,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Are you sure you want to quit? You might not want to lose your progress.",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: 'purple_smile',
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),



                        SizedBox(height: 5),



                        Container(
                          // ... (other code for the "No" button)
                          decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade800.withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                          ),
                       child: ElevatedButton(
                      onPressed: () {
                            // setState(() {
                            //   _isGamePaused = false; 
                            // });
                            setState(() {
                            _showQuitDialog = false;
                          });
                          },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: Color(0xfffc36C655),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "No",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                        ),



                        SizedBox(height: 15),



                        Container(
                          // ... (other code for the "No" button)
                          decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 170, 21, 21).withOpacity(1.0),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(20), // Rounded sides
                          ),
                       child: ElevatedButton(
                      onPressed: () {
                            setState(() {
                              _isGamePaused = false; 
                            });
                            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JigsawMenuScreen(),
                        ),
                      );
                          },
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(280, 30),
                        primary: const Color.fromRGBO(214, 49, 49, 1), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: Colors.white,
                            width: 3.0,
                          ),
                        ),
                      ),
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontFamily: 'purple_smile',
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(), // Empty SizedBox when not shown
          ),
        
                if (_isJigsawStarted)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 3), // for top of pause button
                      Row(
                        children: [
                        //   ElevatedButton(
                          // onPressed: () {
                          //   if (_selectedImage != null) {
                          //     _showImagePreview(context, _selectedImage!);
                          //   }
                          // },
                        //   child: Text('Show Preview'),
                        // ),

                        Container(
                            // padding: EdgeInsets.all(1),
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green, 
                            ),
                            child: IconButton(
                              onPressed: () {
                                if (_selectedImage != null) {
                              _showImagePreview(context, _selectedImage!);
                            }
                            else {
                              showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    width: 300,
                                    height: 300,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/kris.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    ),
                                  ],

                                );
                              },
                            );
                            }
                              },
                              icon: Icon(Icons.image_search),
                              color: Colors.white,
                              iconSize: 30.0, // Adjusted icon size
                            ),
                          ),


                      
                          // Sound Button
                          Container(
                            // padding: EdgeInsets.all(1),
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green, 
                            ),
                            child: IconButton(
                              onPressed: () {
                                // Handle sound button press
                              },
                              icon: Icon(Icons.volume_up),
                              color: Colors.white,
                              iconSize: 30.0, // Adjusted icon size
                            ),
                          ),
                      
                      
                          // Pause Button
                          Container(
                            // padding: EdgeInsets.all(1),
                            margin: EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green, 
                            ),
                            child: IconButton(
                              onPressed: () {
                                
                                setState(() {
                                  _isGamePaused = true;
                                  _showPauseMenu = true;
                                });
                                // _showPauseMenu(context);
                              },
                              icon: Icon(Icons.pause),
                              color: Colors.white,
                              iconSize: 30.0, 
                            ),
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                  ),
              ],
            ),
          ),
        ),
      );
    }



  }

class TimerWidget extends StatefulWidget {
  final bool isGamePaused;
  final bool  isPuzzleComplete;
    final void Function(int) onTimerUpdate; // Add this line

  TimerWidget({required this.isGamePaused, required this.isPuzzleComplete, required this.onTimerUpdate});

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
  _timer = Timer.periodic(Duration(seconds: 1), (timer) {
    if (!widget.isGamePaused) {
      setState(() {
        _seconds++;
        widget.onTimerUpdate(_seconds); // Add this line
      });
    }
  });
}

  String _formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;

    String formattedTime =
        '$hours:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 16,
      ),
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.black, width: 2), // timer border
      ),
      color: const Color.fromARGB(255, 250, 250, 250),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Center(
          child: Text(
            _formatTime(_seconds),
            style: const TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 5, 5, 5),
            ),
          ),
        ),
      ),
    );
    
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}




// make new widget name JigsawWidget
// let move jigsaw blok
class JigsawWidget extends StatefulWidget {

  Widget child;
  Function() callbackSuccess;
  Function() callbackFinish;
  JigsawWidget({required Key key, required this.child, required this.callbackFinish, required this.callbackSuccess})
      : super(key: key);


  @override
  _JigsawWidgetState createState() => _JigsawWidgetState();
}



class _JigsawWidgetState extends State<JigsawWidget> {
  File? _selectedImage; // Declare _selectedImage here


  GlobalKey _globalKey = GlobalKey();
   ui.Image? fullImage;
   Size? size;

   // Define the key to access the _PuzzleWidgetHardState
  GlobalKey<_PuzzleWidgetHardState> _puzzleKey = GlobalKey<_PuzzleWidgetHardState>(); 


  List<List<BlockClass>> images = <List<BlockClass>>[];
  ValueNotifier<List<BlockClass>> blocksNotifier =
      new ValueNotifier<List<BlockClass>>(<BlockClass>[]);
  late CarouselController _carouselController;


  // to save current touch down offset & current index puzzle
  Offset _pos = Offset.zero;
  late int? _index;

  AudioCache audioCache = AudioCache();


  // Add this method to update the image
  Future<void> setNewImage(File? newImage) async {
    await _getImageFromWidget();
  }




// pasted from NO SOUND JIGSAW
  _getImageFromWidget() async {
final RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;

    size = boundary.size;
    var img = await boundary.toImage();
    var byteData = await img?.toByteData(format: ImageByteFormat.png);
    var pngBytes = byteData?.buffer.asUint8List();

    return ui.decodeImage(pngBytes!);
  }


resetJigsaw() {
  fullImage = null; // Set fullImage to null
  images.clear();
  blocksNotifier = ValueNotifier<List<BlockClass>>(<BlockClass>[]);
  blocksNotifier.notifyListeners();
  setState(() {});
}



  Future<void> generaJigsawCropImage() async {
  // 1st we need to create a class for block image
  images = <List<BlockClass>>[];


  // get image from our boundary
  if (fullImage == null) {
    fullImage = await _getImageFromWidget();
  }



  // split image using crop
  int xSplitCount = 5;
  int ySplitCount = 5;


    double widthPerBlock = fullImage!.width / xSplitCount; // change back to width
    double heightPerBlock = fullImage!.height / ySplitCount;


    for (var y = 0; y < ySplitCount; y++) {
      // temporary images
      List<BlockClass> tempImages = <BlockClass>[];


      images.add(tempImages);
      for (var x = 0; x < xSplitCount; x++) {
        int randomPosRow = math.Random().nextInt(2) % 2 == 0 ? 1 : -1;
        int randomPosCol = math.Random().nextInt(2) % 2 == 0 ? 1 : -1;


        Offset offsetCenter = Offset(widthPerBlock / 2, heightPerBlock / 2);


        // make random jigsaw pointer in or out


        ClassJigsawPos jigsawPosSide = new ClassJigsawPos(
          bottom: y == ySplitCount - 1 ? 0 : randomPosCol,
          left: x == 0
              ? 0
              : -images[y][x - 1]
                  .jigsawBlockWidget
                  .imageBox
                  .posSide
                  .right, // ops.. forgot to dclare
          right: x == xSplitCount - 1 ? 0 : randomPosRow,
          top: y == 0
              ? 0
              : -images[y - 1][x].jigsawBlockWidget.imageBox.posSide.bottom,
        );


        double xAxis = widthPerBlock * x;
        double yAxis = heightPerBlock * y; 


        // size for pointing
        double minSize = math.min(widthPerBlock, heightPerBlock) / 15 * 4;


        offsetCenter = Offset(
          (widthPerBlock / 2) + (jigsawPosSide.left == 1 ? minSize : 0),
          (heightPerBlock / 2) + (jigsawPosSide.top == 1 ? minSize : 0),
        );


        // change axis for posSideEffect
        xAxis -= jigsawPosSide.left == 1 ? minSize : 0;
        yAxis -= jigsawPosSide.top == 1 ? minSize : 0;



        // get width & height after change Axis Side Effect
        double widthPerBlockTemp = widthPerBlock +
            (jigsawPosSide.left == 1 ? minSize : 0) +
            (jigsawPosSide.right == 1 ? minSize : 0);
        double heightPerBlockTemp = heightPerBlock +
            (jigsawPosSide.top == 1 ? minSize : 0) +
            (jigsawPosSide.bottom == 1 ? minSize : 0);



        // create crop image for each block
        ui.Image temp = ui.copyCrop(
          fullImage!,
          x: xAxis.round(),
          y: yAxis.round(),
          width: widthPerBlockTemp.round(),
          height: heightPerBlockTemp.round(),
        );


        // get offset for each block show on center base later
        Offset offset = Offset(size!.width / 2 - widthPerBlockTemp / 2,
            size!.height / 2 - heightPerBlockTemp / 2);



        ImageBox imageBox = new ImageBox(
          image: Image.memory(
            ui.encodePng(temp),
            fit: BoxFit.contain,
          ),
          isDone: false,
          offsetCenter: offsetCenter,
          posSide: jigsawPosSide,
          radiusPoint: minSize,
          size: Size(widthPerBlockTemp, heightPerBlockTemp),
        );

        images[y].add(
          new BlockClass(
              jigsawBlockWidget: JigsawBlockWidget(
                imageBox: imageBox,
              ),
              offset: offset,
              offsetDefault: Offset(xAxis, yAxis)),
        );
      }
    }



    blocksNotifier.value = images.expand((image) => image).toList();
    // let random a bit so blok puzzle not in incremet order
    blocksNotifier.value.shuffle();
    blocksNotifier.notifyListeners();
    //  _index = 0;
    setState(() {});

   
  }




  @override
  void initState() {
    // let generate split image
    // forgot to initiate.. haha
    _index = 0;
    _carouselController = new CarouselController();
    super.initState();


    AudioCache audioCache = AudioCache();
    audioCache.load('images/sound.mp3'); // Replace 'snap_sound.mp3' with your sound file

  }




  void playSnapSound() async {
  AudioPlayer result = await audioCache.play('images/sound.mp3'); // Replace 'snap_sound.mp3' with your sound file
  if (result == 1) {
    // success
    print("Sound played successfully");
  } else {
    print("Error playing sound");
  }


}




  @override
  Widget build(BuildContext context) {
    _PuzzleWidgetHardState? puzzleState =
        _puzzleKey.currentState as _PuzzleWidgetHardState?;

    Size sizeBox = MediaQuery.of(context).size;

    bool _isJigsawStarted = puzzleState?.getIsJigsawStarted() ?? false;


    return ValueListenableBuilder(
        valueListenable: blocksNotifier,
        builder: (context, List<BlockClass> blocks, child) {
          List<BlockClass> blockNotDone = blocks
              .where((block) => !block.jigsawBlockWidget.imageBox.isDone)
              .toList();
          List<BlockClass> blockDone = blocks
              .where((block) => block.jigsawBlockWidget.imageBox.isDone)
              .toList();


          return Container(
            // set height for jigsaw base
            child: Container(
              // color: Colors.red,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: sizeBox.width,
                    child: Listener(
                      // listener for move event & up
                      // lets proceed 1st
                      onPointerUp: (event) {
                       
                        if (blockNotDone.length == 0) {
                          resetJigsaw();
                          // can set callback for complete all piece
                          widget.callbackFinish.call();
                        }


                        if (_index == null) {
                          // set carousel for change _index
                          _carouselController.nextPage(
                              duration: Duration(
                                  microseconds:
                                      600)); // lower to make fast move
                          setState(() {
                            // _index = 0;
                          });
                        }
                      },
                      onPointerMove: (event) {
                        if (_index == null || _index! >= blockNotDone.length) return;

                        Offset offset = event.localPosition - _pos;

                        blockNotDone[_index!].offset = offset;


                        if ((blockNotDone[_index!].offset - blockNotDone[_index!].offsetDefault).distance < 5)
                        {
                          // drag block close to default position will trigger this cond


                          blockNotDone[_index!]
                              .jigsawBlockWidget
                              .imageBox
                              .isDone = true;
                          blockNotDone[_index!].offset =
                              blockNotDone[_index!].offsetDefault;


                          // _index = (_index! + 1) % blockNotDone.length; // Move to the next index //causes the 8th piece to glith
                          _index = 0;
                          // not allow index change after success put piece

                          blocksNotifier.notifyListeners();

                          widget.callbackSuccess.call();
                          playSnapSound();


                        }


                        setState(() {});
                      },
                      child: Stack(
                        children: [
                          if (blocks.length == 0) ...[
                            RepaintBoundary(
                              key: _globalKey,
                              child: Container(
                                color: Color.fromARGB(255, 125, 60, 179),
                                height: double.maxFinite,
                                width: double.maxFinite,
                                child: widget.child,
                              ),
                            )
                          ],


                          Offstage(
                            offstage: !(blocks.length > 0), 
                            
                            // EDIT the background of the Jigsaw Base

                            child: Container(
                              color: Colors.white,
                              width: size?.width,
                              height: size?.height,
                              child: CustomPaint(
                                // draw outline base for jigsaw so player can know what shape they want to match
                                painter: JigsawPainterBackground(blocks),
                                child: Stack(
                                  children: [
                                    // we need split up block which done and not done
                                    if (blockDone.length > 0)
                                      ...blockDone.map(
                                        (map) {
                                          return Positioned(
                                            left: map
                                                .offset.dx, // lets turn this off
                                            top: map.offset.dy,
                                            child: Container(
                                              child: map.jigsawBlockWidget,
                                            ),
                                          );
                                        },
                                      ),
                                    if (blockNotDone.length > 0)
                                      ...blockNotDone.asMap().entries.map(
                                        (map) {
                                          return Positioned(
                                            left: map.value.offset
                                                .dx, // let set default so we can see progress 1st .. yeayyy
                                            top: map.value.offset.dy,
                                            child: Offstage(
                                              offstage: !(_index == map.key), 
                                                  // will hide blok which not same index
                                              child: GestureDetector(
                                                // for event touch down to capture current offset on blok
                                                onTapDown: (details) {
                                                  if (map
                                                      .value
                                                      .jigsawBlockWidget
                                                      .imageBox
                                                      .isDone) return;


                                                  setState(() {
                                                    _pos =
                                                        details.localPosition;
                                                    _index = map.key;
                                                  });
                                                },
                                                child: Container(
                                                  child: map
                                                      .value.jigsawBlockWidget,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  

                  // Edit Outside puzzle/ Base of mindful merge
                  
                  Visibility(
                visible: blocks.length > 0, // Only show CarouselSlider when blocks are present
                child: Container(
                  color: Colors.grey[850],
                  height: 90,
                  child: CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      initialPage: _index!,
                      height: 80,
                      aspectRatio: 1,
                      viewportFraction: 0.15,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      disableCenter: false,
                      onPageChanged: (index, reason) {
                        _index = index;
                        setState(() {});
                      },
                    ),
                    items: blockNotDone.map((block) {
                      Size sizeBlock = block.jigsawBlockWidget.imageBox.size;
                      return FittedBox(
                        child: Container(
                          width: sizeBlock.width,
                          height: sizeBlock.height,
                          child: block.jigsawBlockWidget,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  }


}



class JigsawPainterBackground extends CustomPainter {
  List<BlockClass> blocks;

  JigsawPainterBackground(this.blocks);

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // Edit The outline of the jigsaw base

    Paint paint = new Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black12
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    Path path = new Path();


    // loop blocks so we can draw line at base
    this.blocks.forEach((element) {
      Path pathTemp = getPiecePath(
        element.jigsawBlockWidget.imageBox.size,
        element.jigsawBlockWidget.imageBox.radiusPoint,
        element.jigsawBlockWidget.imageBox.offsetCenter,
        element.jigsawBlockWidget.imageBox.posSide,
      );

      path.addPath(pathTemp, element.offsetDefault);
    });


    canvas.drawPath(path, paint);
  }


  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}




class BlockClass {
  Offset offset;
  Offset offsetDefault;
  JigsawBlockWidget jigsawBlockWidget;



  BlockClass({
    required this.offset,
    required this.jigsawBlockWidget,
    required this.offsetDefault,
  });
}




class ImageBox {
  Widget image;
  ClassJigsawPos posSide;
  Offset offsetCenter;
  Size size;
  double radiusPoint;
  bool isDone;




  ImageBox({
    required this.image,
    required this.posSide,
    required this.isDone,
    required this.offsetCenter,
    required this.radiusPoint,
    required this.size,
  });
}




class ClassJigsawPos {
  int top, bottom, left, right;

  ClassJigsawPos({required this.top, required this.bottom, required this.left, required this.right});
}





class JigsawBlockWidget extends StatefulWidget {
  ImageBox imageBox;
  JigsawBlockWidget({ Key? key, required this.imageBox}) : super(key: key);

  @override
  _JigsawBlockWidgetState createState() => _JigsawBlockWidgetState();
}




class _JigsawBlockWidgetState extends State<JigsawBlockWidget> {
  // lets start clip crop image so show like jigsaw puzzle

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: PuzzlePieceClipper(imageBox: widget.imageBox),
      child: CustomPaint(
        foregroundPainter: JigsawBlokPainter(imageBox: widget.imageBox),
        child: widget.imageBox.image,
      ),
    );
  }
}


class JigsawBlokPainter extends CustomPainter {

  ImageBox imageBox;


  JigsawBlokPainter({
    required this.imageBox,
  });
  @override
  void paint(Canvas canvas, Size size) {

  
    Paint paint = new Paint()
      ..color = this.imageBox.isDone
          ? Colors.white.withOpacity(0.2)
          : Colors.white //will use later
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2; // border size of each piece



    canvas.drawPath(
        getPiecePath(size, this.imageBox.radiusPoint,
            this.imageBox.offsetCenter, this.imageBox.posSide),
        paint);



    if (this.imageBox.isDone) {
      Paint paintDone = new Paint()
        ..color = Colors.white.withOpacity(0.2) // color shade of correctly placed pieces
        ..style = PaintingStyle.fill
        ..strokeWidth = 2;
      canvas.drawPath(
          getPiecePath(size, this.imageBox.radiusPoint,
              this.imageBox.offsetCenter, this.imageBox.posSide),
          paintDone);
     
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}




class PuzzlePieceClipper extends CustomClipper<Path> {
  ImageBox imageBox;
  PuzzlePieceClipper({
    required this.imageBox,
  });
  @override
  Path getClip(Size size) {
    // we make function so later custom painter can use same path  
    return getPiecePath(size, this.imageBox.radiusPoint,
        this.imageBox.offsetCenter, this.imageBox.posSide);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}



getPiecePath(
  Size size,
  double radiusPoint,
  Offset offsetCenter,
  ClassJigsawPos posSide,
) {
  Path path = new Path();



  Offset topLeft = Offset(0, 0);
  Offset topRight = Offset(size.width, 0);
  Offset bottomLeft = Offset(0, size.height);
  Offset bottomRight = Offset(size.width, size.height);



  // calculate top point on 4 point
  topLeft = Offset(posSide.left > 0 ? radiusPoint : 0,
          (posSide.top > 0) ? radiusPoint : 0) +
      topLeft;
  topRight = Offset(posSide.right > 0 ? -radiusPoint : 0,
          (posSide.top > 0) ? radiusPoint : 0) +
      topRight;
  bottomRight = Offset(posSide.right > 0 ? -radiusPoint : 0,
          (posSide.bottom > 0) ? -radiusPoint : 0) +
      bottomRight;
  bottomLeft = Offset(posSide.left > 0 ? radiusPoint : 0,
          (posSide.bottom > 0) ? -radiusPoint : 0) +
      bottomLeft;



  // calculate mid point for min & max
  double topMiddle = posSide.top == 0
      ? topRight.dy
      : (posSide.top > 0
          ? topRight.dy - radiusPoint
          : topRight.dy + radiusPoint);
  double bottomMiddle = posSide.bottom == 0
      ? bottomRight.dy
      : (posSide.bottom > 0
          ? bottomRight.dy + radiusPoint
          : bottomRight.dy - radiusPoint);
  double leftMiddle = posSide.left == 0
      ? topLeft.dx
      : (posSide.left > 0
          ? topLeft.dx - radiusPoint
          : topLeft.dx + radiusPoint);
  double rightMiddle = posSide.right == 0
      ? topRight.dx
      : (posSide.right > 0
          ? topRight.dx + radiusPoint
          : topRight.dx - radiusPoint);



  path.moveTo(topLeft.dx, topLeft.dy);
  // top draw
  if (posSide.top != 0)
    path.extendWithPath(
        calculatePoint(Axis.horizontal, topLeft.dy,
            Offset(offsetCenter.dx, topMiddle), radiusPoint),
        Offset.zero);
  path.lineTo(topRight.dx, topRight.dy);
  // right draw
  if (posSide.right != 0)
    path.extendWithPath(
        calculatePoint(Axis.vertical, topRight.dx,
            Offset(rightMiddle, offsetCenter.dy), radiusPoint),
        Offset.zero);
  path.lineTo(bottomRight.dx, bottomRight.dy);
  if (posSide.bottom != 0)
    path.extendWithPath(
        calculatePoint(Axis.horizontal, bottomRight.dy,
            Offset(offsetCenter.dx, bottomMiddle), -radiusPoint),
        Offset.zero);
  path.lineTo(bottomLeft.dx, bottomLeft.dy);
  if (posSide.left != 0)
    path.extendWithPath(
        calculatePoint(Axis.vertical, bottomLeft.dx,
            Offset(leftMiddle, offsetCenter.dy), -radiusPoint),
        Offset.zero);
  path.lineTo(topLeft.dx, topLeft.dy);



  path.close();


  return path;
}




// design each point shape
calculatePoint(Axis axis, double fromPoint, Offset point, double radiusPoint) {
  Path path = new Path();



  if (axis == Axis.horizontal) {
    path.moveTo(point.dx - radiusPoint / 2, fromPoint);
    path.lineTo(point.dx - radiusPoint / 2, point.dy);  
    path.lineTo(point.dx + radiusPoint / 2, point.dy);
    path.lineTo(point.dx + radiusPoint / 2, fromPoint);
  } else if (axis == Axis.vertical) {
    path.moveTo(fromPoint, point.dy - radiusPoint / 2);
    path.lineTo(point.dx, point.dy - radiusPoint / 2);
    path.lineTo(point.dx, point.dy + radiusPoint / 2);
    path.lineTo(fromPoint, point.dy + radiusPoint / 2);
  }



  return path;
}