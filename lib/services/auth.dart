// not indian and currently not use


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:gunita20/models/user.dart';
// import 'package:gunita20/models/user_info_model.dart';
// import 'package:gunita20/screens/settings/user_repository.dart';
// import 'package:gunita20/services/database.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


// class AuthService {

//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   static var instance;

//   // create user obj based on FirebaseUser
//   MyUser? _userFromFirebaseUser(User? user) {
//     return user != null ? MyUser(uid: user.uid) : null;
//   }


//   // auth change user stream (detects if logged in or not to change screens)
  
//   Stream<MyUser?> get user {
//     return _auth.authStateChanges()       // onAuthStateChanged is now authStateChanges
//       .map((User? user) => _userFromFirebaseUser(user));
//   }



//   // register with email and password
//   Future registerWithEmailAndPassword( {required String email, required String password}) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       User? user = result.user;
      
//       // create a new document for the user with the uid
//       // to do: incorporate with forms

//       // await DatabaseService(uid: user?.uid).updateUserData('last name','first name', 'middle name', 'jr','gender');
//        return _userFromFirebaseUser(user!);
//     } 
//     catch (error) {
//       print(error.toString());
//       return null;
//     } 
//   }

// // made method to add user details >> might need to locally put in signupscreen [already there]
//   Future addUserDetails(
//     String firstName, String lastName, String middleName, String nameExtension, String gender) async {

//       final String? uid;
      
      
//       await FirebaseFirestore.instance.collection('users').add({
//         'last name' : lastName,
//         'first name' : firstName,
//         'middle name' : middleName,
//         'name extension' : nameExtension,
//         'gender' : gender,
//       });
//     }

//     // made method to add user  details >> might need to locally put in signupscreen [already there]
//     Future addUserAccountDetails(
//     String username, String email) async {

//       final String? uid;
      
      
//       await FirebaseFirestore.instance.collection('users').add({
//         'username' : username,
//         'email' : email,
//       });
//     }
  

//   // sign out
//   Future signOut() async {
//     try {
//       return await _auth.signOut();
//     } catch (error) {
//       print(error.toString());
//       return null;
//     }
//   }

// // sign up controller stuff from india profile guy

// final userRepo = Get.put(UserRepository());

// void createUser(UserInfoModel user) async {
//   await userRepo.createUser(user);
// }


// }