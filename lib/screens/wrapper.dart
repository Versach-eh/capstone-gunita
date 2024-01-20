import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/get_started.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/landingpage_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

     final user = Provider.of<User?>(context); // might need a ?
    // print(user);
    
    // // return either the Home or Authenticate widget
    // if (user == null){
    //   return Authenticate();    // authenticate.dart that basically just navigates to cover page (get_started.dart)
    // } else {
    //   return HomeScreen();

    


    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const CoverPage();
          }
        },
      ),
    );
    }

  }
