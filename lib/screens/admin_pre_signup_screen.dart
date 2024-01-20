import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/congratulations.dart';
// import 'AdminPreSignUpScreen2.dart';

class AdminPreSignUpScreen extends StatefulWidget {
  const AdminPreSignUpScreen({super.key});

  @override
  State<AdminPreSignUpScreen> createState() => _AdminPreSignUpScreenState();
}

class _AdminPreSignUpScreenState extends State<AdminPreSignUpScreen> {

  final _lastNameTextController = TextEditingController();
  final _firstNameTextController = TextEditingController();
  final _middleNameTextController = TextEditingController();
  final _nameExtensionTextController = TextEditingController();
  final _genderController = TextEditingController();
  final _birthdayTextController = TextEditingController();

  String gender = "";

  final _formkey = GlobalKey<FormState>();

  Future addUserDetails(String lastName, String firstName, String middleName, String nameExtension, String gender) 
  async {
    final user = FirebaseAuth.instance.currentUser!;
    //await FirebaseFirestore.instance.collection('Users/${user.uid}/UserDetails').doc(userInfoModel).update({
      await FirebaseFirestore.instance.collection('Admins/${user.uid}/AdminDetails').add({
        'lastName' : lastName,
        'firstName' : firstName,
        'middleName' : middleName,
        'nameExtension' : nameExtension,
        'gender' : gender,
      });
    }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xffe7f9f9),
          body: Container(
            margin: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _header(context),
                  _inputFields(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _header(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // Return to the previous page
                },
              ),
            ],
          ),
          const Text(
            "Welcome!",
            style: TextStyle(
              fontSize: 37,
              fontWeight: FontWeight.bold,
              color: Color(0xff4f22cd),
            ),
          ),
          const Text(
            "Create new account",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: Color(0xff8a8a8a),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputFields(BuildContext context) {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 12,),
            const Text(
              "Last name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff020003),
              ),
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "",
                  fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (val) =>
                    val?.isEmpty ?? true ? 'Enter your last name' : null,
                // onChanged: (val) {
                //   setState(() => lastName = val);
                // },
                controller: _lastNameTextController,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "First name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff020003),
              ),
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "",
                  fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (val) =>
                    val?.isEmpty ?? true ? 'Enter your first name' : null,
                controller: _firstNameTextController,
                // onChanged: (val) {
                //   setState(() => firstName = val);
                // },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Middle name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff020003),
              ),
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "",
                  fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (val) =>
                    val?.isEmpty ?? true ? 'Enter your middle name' : null,
                // onChanged: (val) {
                //   setState(() => middleName = val);
                // },
                controller: _middleNameTextController,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Extension name",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff020003),
              ),
            ),
            SizedBox(
              width: 200,
              height: 40,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "",
                  fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                  filled: true,
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (val) =>
                    val?.isEmpty ?? true ? 'Enter your Extension name' : null,
                // onChanged: (val) {
                //   setState(() => extensionName = val);
                // },
                controller: _nameExtensionTextController,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Birthday",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff020003),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "mm/dd/yy",
                      fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                      filled: true,
                      prefixIcon: const Icon(Icons.cake_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (val) =>
                        val?.isEmpty ?? true ? 'Enter your Birthday' : null,
                    // onChanged: (val) {
                    //   setState(() => birthday = val);
                    // },
                    controller: _birthdayTextController,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: "Gender",
                      fillColor: const Color(0xff83dbfe).withOpacity(0.5),
                      filled: true,
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: ['Male', 'Female'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (val) {
                      // String gender = "";                  // maybe put at top
                      setState(() => gender = val!);
                    },
                    validator: (val) =>
                        val?.isEmpty ?? true ? 'Select your Gender' : null,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                // if (_formkey.currentState!.validate()) {
                //   print(lastName);
                //   print(firstName);
                //   print(middleName);
                //   print(extensionName);
                //   print(birthday);
                //   print(gender);
      
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => HomeScreen()),
                //   );
                // }
      
                if (_formkey.currentState!.validate()){
      
                // FirebaseAuth.instance
                //     .createUserWithEmailAndPassword(
                //         email: _emailTextController.text,
                //         password: _passwordTextController.text)
                //     .then((value) {
                //   print("Created New Account");
                
                addUserDetails(
                  _lastNameTextController.text.trim(), 
                  _firstNameTextController.text.trim(),
                  _middleNameTextController.text.trim(),
                  _nameExtensionTextController.text.trim(),
                  gender.trim()
                  );
      
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    const Congratulations()), (Route<dynamic> route) => false);
                }
                //   }).onError((error, stackTrace) {
                //     print("Error ${error.toString()}");
                // }
                // );
              },
              child: const Text(
                "NEXT",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffffffff),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4f22cd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                minimumSize: const Size(280, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
