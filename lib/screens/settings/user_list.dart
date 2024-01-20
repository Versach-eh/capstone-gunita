// import 'package:flutter/material.dart';
// import 'package:gunita20/models/user_info_model.dart';
// import 'package:gunita20/screens/settings/user_tile.dart';
// import 'package:provider/provider.dart';

// class UserList extends StatefulWidget {
//   @override
//   _UserListState createState() => _UserListState();
// }

// class _UserListState extends State<UserList> {
//   @override
//   Widget build(BuildContext context) {

//     final users = Provider.of<List<UserInfoModel>?>(context) ?? [];


//     users.forEach((user) {
//       print(user.last_name);
//       print(user.first_name);
//       print(user.middle_name);
//       print(user.name_extension);
//       print(user.gender);
//     });

//     return ListView.builder(          // cycle throuth the users list
//       itemCount: users.length,
//       itemBuilder: (context, index) {
//         return UserTile(user: users[index]);   // UserTile is format template for display of user info

//       },
//     );
//   }
// }