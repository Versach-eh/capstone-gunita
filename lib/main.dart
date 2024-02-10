// ignore_for_file: prefer_const_constructors
// testing gunita 20

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/firebase_options.dart'; 
// import 'package:gunita20/screens/get_started.dart';
// import 'package:gunita20/screens/signin_screen.dart';
import 'package:gunita20/screens/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
} 


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return StreamProvider<MyUser?>.value(
    //   initialData: null,
    //   value: AuthService().user,
    //   child: MaterialApp(
    //     home: Wrapper(),
    //   ),
    // );


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Wrapper(),                    // change back to Wrapper(). temporrarily changed for gallery checking
    );
  }
}
