// // ignore_for_file: prefer_const_constructors, dead_code

// import 'package:flutter/material.dart';
// import 'package:gunita20/screens/album/album_screen.dart';
// import 'package:gunita20/screens/gamelibrary_screen.dart';
// import 'package:gunita20/screens/landingpage_screen2.dart';
// import 'package:gunita20/screens/settings/settings_screen.dart';
// import 'account.dart';

// class EditName extends StatefulWidget {
//   @override
//   State<EditName> createState() => _EditNameState();
// }

// class _EditNameState extends State<EditName> {
//   final _formkey = GlobalKey<FormState>();

//   String lastName = '';
//   String firstName = '';
//   String middleName = '';
//   String extensionName = '';

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: MaterialApp(
//         home: Scaffold(
//           backgroundColor: Color(0xffe7f9f9),
//           body: SingleChildScrollView(
//             child: Container(
//               margin: EdgeInsets.all(24),
//               child: FutureBuilder(
//                 builder: (context,snapshot) {
//                   if(snapshot.connectionState == ConnectionState.done) {
//                     if (snapshot.hasData) {
//                       return Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Row(
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.pop(context); // Return to the previous page
//               },
//             ),
//           ],
//         ),
//         Text(
//           "Name",
//           style: TextStyle(
//             fontSize: 37,
//             fontWeight: FontWeight.bold,
//             color: Color(0xff4f22cd),
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//       ],
//     ),
//                     SingleChildScrollView(
//                       child: _inputFields(context),
//                     ),
//                     SizedBox(height: 20), // Add a SizedBox for spacing
//                     _saveButton(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           bottomNavigationBar: BottomAppBar(
//             child: Container(
//               padding: EdgeInsets.all(20),
//               color: Colors.white.withOpacity(1.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildNavigationButton(Icons.home, () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LandingPage2()),
//                     );
//                   }),
//                   _buildNavigationButton(Icons.games, () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => GameLibrary()),
//                     );
//                   }),
//                   _buildNavigationButton(Icons.photo_album, () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Album()),
//                     );
//                   }),
//                   _buildNavigationButton(Icons.settings, () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Settings()),
//                     );
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget _header(context) { // remove widget trtuen eme just gonna paste the column to above
//   //   return Column(
//   //     crossAxisAlignment: CrossAxisAlignment.start,
//   //     children: [
//   //       Row(
//   //         children: [
//   //           IconButton(
//   //             icon: Icon(Icons.arrow_back),
//   //             onPressed: () {
//   //               Navigator.pop(context); // Return to the previous page
//   //             },
//   //           ),
//   //         ],
//   //       ),
//   //       Text(
//   //         "Name",
//   //         style: TextStyle(
//   //           fontSize: 37,
//   //           fontWeight: FontWeight.bold,
//   //           color: Color(0xff4f22cd),
//   //         ),
//   //       ),
//   //       SizedBox(
//   //         height: 20,
//   //       ),
//   //     ],
//   //   );
//   // }

//   Widget _inputFields(BuildContext context) {
//     return Form(
//       key: _formkey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             "Last name",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff020003),
//             ),
//           ),
//           Container(
//             width: 200,
//             height: 40,
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: "",
//                 fillColor: Colors.white,
//                 filled: true,
//                 prefixIcon: Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(18),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               validator: (val) =>
//                   val?.isEmpty ?? true ? 'Enter your last name' : null,
//               onChanged: (val) {
//                 setState(() => lastName = val);
//               },
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             "First name",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff020003),
//             ),
//           ),
//           Container(
//             width: 200,
//             height: 40,
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: "",
//                 fillColor: Colors.white,
//                 filled: true,
//                 prefixIcon: Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(18),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               validator: (val) =>
//                   val?.isEmpty ?? true ? 'Enter your first name' : null,
//               onChanged: (val) {
//                 setState(() => firstName = val);
//               },
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             "Middle name",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff020003),
//             ),
//           ),
//           Container(
//             width: 200,
//             height: 40,
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: "",
//                 fillColor: Colors.white,
//                 filled: true,
//                 prefixIcon: Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(18),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               validator: (val) =>
//                   val?.isEmpty ?? true ? 'Enter your middle name' : null,
//               onChanged: (val) {
//                 setState(() => middleName = val);
//               },
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text(
//             "Extension name",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               color: Color(0xff020003),
//             ),
//           ),
//           Container(
//             width: 200,
//             height: 40,
//             child: TextFormField(
//               decoration: InputDecoration(
//                 hintText: "",
//                 fillColor: Colors.white,
//                 filled: true,
//                 prefixIcon: Icon(Icons.person),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(18),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//               validator: (val) =>
//                   val?.isEmpty ?? true ? 'Enter your Extension name' : null,
//               onChanged: (val) {
//                 setState(() => extensionName = val);
//               },
//             ),
//           ),
//         ],
//       );
//                     }
//                   } else {
//                     return Center(child: CircularProgressIndicator(),);
//                   }
//                 },
//                   // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   // children: [
                    
//     );
//   }

//   Widget _saveButton() {
//     return ElevatedButton(
//       onPressed: () {
//         if (_formkey.currentState!.validate()) {
//           _showConfirmationDialog(
//               context, 'Save Changes', 'Do you want to save the changes?');
//         }
//       },
//       child: Text(
//         "Save",
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           color: Color(0xffffffff),
//         ),
//       ),
//       style: ElevatedButton.styleFrom(
//         primary: Colors.green,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         minimumSize: Size(100, 50),
//       ),
//     );
//   }

//   void _showConfirmationDialog(
//       BuildContext context, String title, String message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             title,
//             style: TextStyle(fontSize: 20),
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 message,
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontStyle: FontStyle.normal, // Add fontStyle property
//                 ),
//               ),
//               SizedBox(
//                   height: 15), // Add spacing between the message and buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment
//                     .spaceBetween, // Align buttons with equal space between them
//                 children: <Widget>[
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the dialog
//                     },
//                     child: Text(
//                       'No',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.red,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       minimumSize: Size(100, 40), // Increase button size
//                     ),
//                   ),
//                   SizedBox(width: 10), // Add spacing between buttons
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop(); // Close the dialog
//                       _saveChanges();
//                     },
//                     child: Text(
//                       'Yes',
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       primary: Colors.green,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       minimumSize: Size(100, 40), // Increase button size
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _saveChanges() {
//     print(lastName);
//     print(firstName);
//     print(middleName);
//     print(extensionName);

//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => Account()),
//     );
//   }

//   Widget _buildNavigationButton(IconData icon, VoidCallback onPressed) {
//     return IconButton(
//       icon: Icon(
//         icon,
//         size: 30,
//         color: Color(0xff959595),
//       ),
//       onPressed: onPressed,
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gunita20/screens/album/album_screen.dart';
import 'package:gunita20/screens/gamelibrary_screen.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/settings/account/account.dart';
import 'package:gunita20/screens/settings/settings_screen.dart';

class EditName extends StatefulWidget {
  const EditName({super.key});

  @override
  State<EditName> createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {
  final _formkey = GlobalKey<FormState>();

  String lastName = '';
  String firstName = '';
  String middleName = '';
  String extensionName = '';

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
          "Name",
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
            "Last name",
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
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) =>
                  val?.isEmpty ?? true ? 'Enter your last name' : null,
              onChanged: (val) {
                setState(() => lastName = val);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "First name",
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
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) =>
                  val?.isEmpty ?? true ? 'Enter your first name' : null,
              onChanged: (val) {
                setState(() => firstName = val);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Middle name",
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
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) =>
                  val?.isEmpty ?? true ? 'Enter your middle name' : null,
              onChanged: (val) {
                setState(() => middleName = val);
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Extension name",
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
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (val) =>
                  val?.isEmpty ?? true ? 'Enter your Extension name' : null,
              onChanged: (val) {
                setState(() => extensionName = val);
              },
            ),
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
    print(lastName);
    print(firstName);
    print(middleName);
    print(extensionName);

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

