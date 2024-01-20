// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:gunita20/models/user.dart';
// import 'package:gunita20/models/user_info_model.dart';

// class DatabaseService {

//   final String? uid;
//   DatabaseService({ this.uid });

//   // collection reference
//   // create user collection?
//   final CollectionReference userCollection = FirebaseFirestore.instance.collection('users'); 

//   Future<void> updateUserData(String last_name, String first_name, String middle_name, String name_extension, String gender) 
//   async {
//     return await userCollection.doc(uid).set({
//       'last_name': last_name,
//       'first_name': first_name,
//       'middle_name': middle_name,
//       'name_extension': name_extension,
//       // 'birthday': birthday,
//       'gender': gender,
//     });
//   }

//   // create ADMIN collection?
//   final CollectionReference adminCollection = FirebaseFirestore.instance.collection('admins'); 

//   Future<void> updateAdminData(String last_name, String first_name, String middle_name, String name_extension, String gender) 
//   async {
//     return await adminCollection.doc(uid).set({
//       'last_name': last_name,
//       'first_name': first_name,
//       'middle_name': middle_name,
//       'name_extension': name_extension,
//       // 'birthday': birthday,
//       'gender': gender,
//     });
//   }



//    List<UserInfoModel> _userListFromSnapshot(QuerySnapshot snapshot) {
//     return snapshot.docs.map((doc){
//       return UserInfoModel(

//         last_name: doc.get("last_name") ?? "",
//         first_name: doc.get("first_name") ?? "",
//         middle_name: doc.get("middle_name") ?? "",
//         name_extension: doc.get("name_extension") ?? "",
//         gender: doc.get("gender") ?? "",
//       );
//     }).toList();
//   }

//   // userData from Sanpshot
//   UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
//     return UserData(
//       uid: uid!,
//       last_name: snapshot.get('last_name'),
//       first_name: snapshot.get('first_name'),
//       middle_name: snapshot.get('middle_name'),
//       name_extension: snapshot.get('name_extension'),
//       gender: snapshot.get('gender')
//     );
//   }


//   // get Users Stream
//   Stream<List<UserInfoModel>>? get users {
//     // try{
//     return userCollection.snapshots().map(_userListFromSnapshot);
//     // }
//     // catch (error) {
//     //   print(error.toString());
//     //   return null;
//     // }
//   }

//   // get user doc stream
//   Stream <UserData> get userData {
//     return userCollection.doc(uid).snapshots().
//     map(_userDataFromSnapshot);
//   }

// }