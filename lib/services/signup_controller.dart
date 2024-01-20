// simillar to all auth stuff done by INDIAN GUY

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunita20/models/user_info_model.dart';
import 'package:gunita20/screens/settings/user_repository.dart';
import 'package:gunita20/services/authentication_repository.dart';


class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // TextField Controllers to get data from Textfields
  final contactNumber = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final last_name = TextEditingController();
  final first_name = TextEditingController();
  final middle_name = TextEditingController();
  final name_extension = TextEditingController();
  final gender = TextEditingController();

  final userRepo = Get.put(UserRepository());

  // register user
  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }

  // create user document in firestore
  Future <void> createUser(UserInfoModel user) async {
    await userRepo.createUser(user);
  }

}