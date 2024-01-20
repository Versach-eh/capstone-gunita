import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';

import 'password.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({super.key});

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final _formkey = GlobalKey<FormState>();

  String currentPassword = '';
  String newPassword = '';
  String confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xffDBE9F7),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _header(context),
                  SingleChildScrollView(
                    child: _inputFields(context),
                  ),
                  const SizedBox(height: 20), // Add a SizedBox for spacing
                  _saveButton(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white.withOpacity(1.0),
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
          ),
        ),
      ),
    );
  }

  Widget _header(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context); // Return to the previous page
              },
            ),
          ],
        ),
        const Text(
          "Change Password",
          style: TextStyle(
            fontSize: 37,
            fontWeight: FontWeight.bold,
            color: Color(0xff4f22cd),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _inputFields(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Current password",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff020003),
            ),
          ),
          SizedBox(
            width: 200,
            height: 40,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) =>
                  val?.isEmpty ?? true ? 'Enter your current password' : null,
              onChanged: (val) {
                setState(() => currentPassword = val);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "New password",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff020003),
            ),
          ),
          SizedBox(
            width: 200,
            height: 40,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) =>
                  val?.isEmpty ?? true ? 'Enter your new password' : null,
              onChanged: (val) {
                setState(() => newPassword = val);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Re-type new password",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff020003),
            ),
          ),
          SizedBox(
            width: 200,
            height: 40,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) =>
                  val?.isEmpty ?? true ? 'Enter your new password' : null,
              onChanged: (val) {
                setState(() => confirmPassword = val);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget _saveButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _showConfirmationDialog(
              context, 'Save Changes', 'Do you want to save the changes?');
        }
      },
      child: const Text(
        "Save",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        minimumSize: const Size(100, 50),
      ),
    );
  }

  void _showConfirmationDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                message,
                style: const TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.normal, // Add fontStyle property
                ),
              ),
              const SizedBox(
                  height: 30), // Add spacing between the message and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Align buttons with equal space between them
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(100, 40), // Increase button size
                    ),
                  ),
                  const SizedBox(width: 3), // Add spacing between buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      _saveChanges();
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(100, 40), // Increase button size
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _saveChanges() {
    print(currentPassword);
    print(newPassword);
    print(confirmPassword);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Password()),
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
