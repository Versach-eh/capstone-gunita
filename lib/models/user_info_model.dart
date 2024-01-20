// we using this one to edit profile 07-04-23

import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoModel {
  // final String? id;
  // final String last_name;
  // final String first_name;
  // final String middle_name;
  // final String name_extension;
  // final String gender;

  final String? id;
  final String contactNumber;
  final String email;
  final String password;
  // final String confirmPassword;

  const UserInfoModel({
    this.id,
    // required this.last_name,
    // required this.first_name,
    // required this.middle_name,
    // required this.name_extension,
    // required this.gender

    required this.contactNumber,
    required this.email,
    required this.password,
    // required this.confirmPassword
    });

  toJson(){
    return{
    // "last name": last_name,
    // "first name": first_name,
    // "middle name": middle_name,
    // "name extension": name_extension,
    // "gender": gender,

    "contact number" : contactNumber,
    "email" : email,
    "password": password,
    };
  }

  // convert document snapshots to our model
  factory UserInfoModel.fromSnapshot(DocumentSnapshot <Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserInfoModel(
      id: document.id,
      contactNumber: data["contact number"],    // must reflect on document details in firestore
      email: data["email"],
      password: data["password"]
      );
  }

}