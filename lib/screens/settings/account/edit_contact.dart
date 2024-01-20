import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';
import 'account.dart';

class ContactNumber extends StatefulWidget {
  const ContactNumber({super.key});

  @override
  State<ContactNumber> createState() => _ContactNumberState();
}

class _ContactNumberState extends State<ContactNumber> {
  final _formkey = GlobalKey<FormState>();

  // final ContactInfo contactifo;

  String contactNumber = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xffe7f9f9),
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
          "Contact Information",
          style: TextStyle(
            fontSize: 33,
            fontWeight: FontWeight.bold,
            color: Color(0xff4f22cd),
          ),
        ),
        const SizedBox(
          height: 30,
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
            "Contact Number",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff020003),
            ),
          ),
          SizedBox(
            width: 80, // Adjust the width as needed
            height: 40, // Adjust the height as needed
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "",
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) =>
                  val?.isEmpty ?? true ? 'Enter your contact number' : null,
              onChanged: (value) {
                setState(() {
                  // widget.image.textInfo = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Email",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xff020003),
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "",
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(Icons.email_outlined),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
            ),
            validator: (val) => val!.isEmpty ? 'Enter your email' : null,
            onChanged: (val) {
              setState(() => email = val);
            },
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
                  height: 15), // Add spacing between the message and buttons
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
                  const SizedBox(width: 10), // Add spacing between buttons
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
    print(contactNumber);
    print(email);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Account()),
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
