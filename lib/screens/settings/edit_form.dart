// import 'package:flutter/material.dart';
// import 'package:gunita20/models/user.dart';
// import 'package:gunita20/reusable_widgets/constants.dart';
// import 'package:gunita20/screens/loading.dart';
// import 'package:gunita20/services/database.dart';
// import 'package:provider/provider.dart';

// // FIX FORM >> STOP ENDLESS LOADINGGGGG

// class EditForm extends StatefulWidget {
//   const EditForm({super.key});

//   @override
//   State<EditForm> createState() => _EditFormState();
// }

// class _EditFormState extends State<EditForm> {

//   final _formKey = GlobalKey<FormState>();
//   final List<String> gender= ['Male', 'Female'];
//   final List<String> name_extension= ['','jr.', 'sr.', 'I', 'II', 'III'];

//   // form values
//   String? _currentLastName;     // maybe replace ? with late if error occurs
//   String? _currentFirstName;
//   String? _currentMiddleName;
//   String? _currentNameExtension;
//   String? _currentGender;

//   @override
//   Widget build(BuildContext context) {

//     final user = Provider.of<MyUser?>(context);       // grants you access to user id via stream

//     return StreamBuilder<UserData>(
//       stream: DatabaseService(uid: user?.uid).userData,     // maybe replace ?. with !.
//       builder: (context, snapshot) {
        
//         if (snapshot.hasData) {
//           UserData? userData = snapshot.data;

//           return 
//           Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Text(
//                   'Update Profile Information.',
//                   style: TextStyle(fontSize: 18.0),
//                 ),
//                 SizedBox(height: 20.0),
      
//                 TextFormField(                        // LAST NAME
//                   initialValue: userData?.last_name,
//                   decoration: textInputDecoration,
//                   validator: (val) => val!.isEmpty ? 'Please enter last name' : null,
//                   onChanged: (val) => setState(() => _currentLastName = val),
//                 ),
//                 SizedBox(height: 10.0),
      
//                 TextFormField(                        // FIRST NAME
//                   initialValue: userData?.first_name,
//                   decoration: textInputDecoration,
//                   validator: (val) => val!.isEmpty ? 'Please enter first name' : null,
//                   onChanged: (val) => setState(() => _currentFirstName = val),
//                 ),
//                 SizedBox(height: 10.0),
      
//                 TextFormField(                             // MIDDLE NAME
//                   initialValue: userData?.middle_name,
//                   decoration: textInputDecoration,
//                   validator: (val) => val!.isEmpty ? 'Please enter middle name' : null,
//                   onChanged: (val) => setState(() => _currentMiddleName = val),
//                 ),
//                 SizedBox(height: 10.0),
      
//                 // dropdown                               // NAME EXTENSION
//                 DropdownButtonFormField(
//                   value: _currentNameExtension ?? userData?.name_extension,     // display value
//                   decoration: textInputDecoration,
//                   items: name_extension.map((nameExtension) {
//                     return DropdownMenuItem(
//                       value: nameExtension,               // actual value
//                       child: Text(nameExtension),
//                     );
//                   }).toList(),
//                   onChanged: (val) => setState(() => _currentNameExtension = val as String? ),
//                 ),
      
//                 DropdownButtonFormField(                 // GENDER
//                   value: _currentGender ?? userData?.gender,      // display value
//                   decoration: textInputDecoration,
//                   items: gender.map((genders) {
//                     return DropdownMenuItem(
//                       value: genders,                   // actual value
//                       child: Text(genders),
//                     );
//                   }).toList(),
//                   onChanged: (val) => setState(() => _currentGender = val as String? ),
//                 ),
      
//                 // slider
      
//                 SizedBox(height: 10.0),
      
//                 ElevatedButton(child: Text('UPDATE'),
//                 style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.resolveWith((states) {
//                   if (states.contains(MaterialState.pressed)) {
//                     return Colors.white;
//                   }
//                   return Colors.purple[900];
//                 }),
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
      
//                   onPressed: () async {
//                     if(_formKey.currentState!.validate()){
//                       await DatabaseService(uid: user?.uid).updateUserData(
//                         _currentLastName ?? snapshot.data!.last_name, 
//                         _currentFirstName ?? snapshot.data!.first_name, 
//                         _currentMiddleName ?? snapshot.data!.middle_name,
//                         _currentNameExtension ?? snapshot.data!.name_extension,
//                         _currentGender ?? snapshot.data!.gender,
//                       );
//                       Navigator.pop(context);
//                   }
//         })]),
//           );

//         }

//         else {
//           return Loading();
//         }
        
//       }
//     );
//   }
// }