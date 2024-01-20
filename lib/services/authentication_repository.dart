import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/landingpage_screen.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {    //  Stream ~~~~ this listens to auth changes
    firebaseUser = _auth.currentUser as Rx<User?>;
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }


// sets initial screen (simillar to wrapper?)
  _setInitialScreen(User? user) {
    user == null ? Get.offAll(() => const LandingPage()) : Get.offAll(() => const HomeScreen());
  }

// SIGN UP FIREBASE
  Future <void> createUserWithEmailAndPassword(String email, String password)  async {
    try {
    await _auth.createUserWithEmailAndPassword(email: email, password: password); 
    } catch (_) {}
  }

// SIGN IN FIREBASE
  Future <void> loginWithEmailAndPassword(String email, String password)  async {
  try {
    await _auth.createUserWithEmailAndPassword(email: email, password: password); 
    } catch (_) {}
  }

// SIGN OUT FIREBASE
  Future <void> logout() async => await _auth.signOut();

}