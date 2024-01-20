import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunita20/models/user_info_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
                                                  // store user in firestore / CREATE NEW DOCUMENT IN FIRESTORE
  createUser(UserInfoModel user) async {
    await _db.collection('Users').add(user.toJson()).whenComplete(
      () => Get.snackbar('Success', 'Your account has been created',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.1),
      colorText: Colors.green),
    ).catchError((error,StackTrace) {
      Get.snackbar('Error', 'Something went wrong. Try again',
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.red);
      print(error.toString());
    });
  }

  // Step 2

  // Fetch single User Details
  Future<UserInfoModel> getUserDetails(String email) async {
    final snapshot = await _db.collection("Users").where("email",isEqualTo: email).get(); // get data deteial with this email
    final userData = snapshot.docs.map((e) => UserInfoModel.fromSnapshot(e)).single; // return single value
    return userData;

  }

  // Fetch ALL Users
  Future<List<UserInfoModel>> allUser() async {
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => UserInfoModel.fromSnapshot(e)).toList(); // return single value
    return userData;

  }

}