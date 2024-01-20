import 'package:get/get.dart';
import 'package:gunita20/screens/settings/user_repository.dart';
import 'package:gunita20/services/authentication_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  getUserData() {}
}

final _authRepo = Get.put(AuthenticationRepository());
final _userRepo = Get.put(UserRepository());


// STEP 3 - get user email and pass to UserRepository to fetch user record.
// for current user???
getUserData() {
  final email = _authRepo.firebaseUser.value?.email; // access to values
  if(email != null) {
    return _userRepo.getUserDetails(email);
  } else {
    Get.snackbar("Error", "Log in to continue");
  }
}