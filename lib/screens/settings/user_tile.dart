// import 'package:flutter/material.dart';
// import 'package:gunita20/models/user_info_model.dart';

// class UserTile extends StatelessWidget {

//   final UserInfoModel? user;
//   UserTile ({this.user});


//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Card(
//         margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
//         child: ListTile(
//           leading: CircleAvatar(
//             radius: 25.0,
//           ),
//           title: Text('${user!.last_name}, ${user!.first_name} ${user!.middle_name}'),
//           subtitle: Text('Gender: ${user!.gender} '),
//         ),
//       ),
//     );
//   }
// }