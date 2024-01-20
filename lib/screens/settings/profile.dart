// import 'package:flutter/material.dart';
// import 'package:gunita20/models/user_info_model.dart';
// import 'package:gunita20/screens/settings/edit_form.dart';
// import 'package:gunita20/screens/settings/user_list.dart';
// import 'package:gunita20/services/auth.dart';
// import 'package:gunita20/services/database.dart';
// import 'package:provider/provider.dart';

// class Profile extends StatelessWidget {

//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {

//                                               // panel pop up from below
//     void _showEditPanel() {
//       showModalBottomSheet<dynamic> (
//       isScrollControlled: true,
//       context: context,
//       builder: (context) {
//         return Container(
//           height: MediaQuery.of(context).size.height * 0.75,
//           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
//           child: EditForm(),
//         );
//       });
//     }

//     return StreamProvider<List<UserInfoModel>?>.value(
//       initialData: null,
//       value: DatabaseService().users,
//       child: Scaffold(
//         backgroundColor: Colors.brown[50],
//         appBar: AppBar(
//           title: Text('Manage Profile'),
//           backgroundColor: Colors.purple[800],
//           elevation: 0.0,
//           actions: <Widget>[
//             TextButton.icon(
//               icon: Icon(Icons.edit),
//               label: Text('edit'),
//               style: ButtonStyle(
//     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//   ),
//               onPressed: () => _showEditPanel(),
//             )
//           ],
//         ),
//         body: UserList(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({super.key});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  User? _currentUser;
  late FirebaseFirestore _firestore;

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _firestore = FirebaseFirestore.instance;
  }

  Future<void> _getCurrentUser() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: _currentUser == null
          ? const Center(child: Text('No user signed in'))
          : StreamBuilder<DocumentSnapshot>(
              stream: _firestore.collection('users').doc(_currentUser!.uid).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No user data found'));
                }

                final userData = snapshot.data!.data();
                if (userData == null) {
                  return const Center(child: Text('No user data found'));
                }

                final lastName = userData;
                final firstName = userData;
                final middleName = userData;
                final nameExtension = userData;
                final gender = userData;

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Last Name: $lastName'),
                      Text('First Name: $firstName'),
                      Text('Middle Name: $middleName'),
                      Text('Middle Initial: $nameExtension'),
                      Text('Gender: $gender'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
