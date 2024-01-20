// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gunita20/screens/settings/account/user_details.dart';
import 'package:gunita20/services/firebase_service.dart';

class UserDetailsScreen extends StatefulWidget {
  final String userId;

  const UserDetailsScreen({super.key, required this.userId});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _middleNameController = TextEditingController();
  final TextEditingController _nameExtensionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    FirebaseService firestoreService = FirebaseService();
    UserDetails? userDetails =
        await firestoreService.getCurrentUserDetails(widget.userId);

    if (userDetails != null) {
      _firstNameController.text = userDetails.firstName;
      _lastNameController.text = userDetails.lastName;
      _middleNameController.text = userDetails.middleName;
      _nameExtensionController.text = userDetails.nameExtension;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xff4f22cd),
        title: Text('Edit Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(filled:true, fillColor:Colors.white, labelText: 'First Name',labelStyle:TextStyle(fontSize:23),
                border: OutlineInputBorder(),),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(filled:true, fillColor:Colors.white, labelText: 'Last Name',labelStyle:TextStyle(fontSize:23),
                border: OutlineInputBorder(),),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _middleNameController,
              decoration: InputDecoration(filled:true, fillColor:Colors.white, labelText: 'Middle Name',labelStyle:TextStyle(fontSize:23),
                border: OutlineInputBorder(),),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameExtensionController,
              decoration: InputDecoration(filled:true, fillColor:Colors.white, labelText: 'Name Extension',labelStyle:TextStyle(fontSize:23),
                border: OutlineInputBorder(),),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveUserDetails,
              child: Text('Save',style: TextStyle(fontSize: 23),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color(0xff4f22cd))
              ),
            ),
          ],
          
        ),
      ),
    );
  }

  void _saveUserDetails() async {
    FirebaseService firestoreService = FirebaseService();
    UserDetails userDetails = UserDetails(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      middleName: _middleNameController.text,
      nameExtension: _nameExtensionController.text,
    );

    await firestoreService.updateUserDetails(widget.userId, userDetails);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User details updated successfully.')),
    );
  }
}