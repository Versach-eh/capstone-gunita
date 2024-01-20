import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gunita20/models/user_info_model.dart';
import 'package:gunita20/screens/admin_pre_signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gunita20/services/signup_controller.dart';

class AdminSignUpScreen extends StatefulWidget {
  const AdminSignUpScreen({super.key});
  @override
  _AdminSignUpScreenState createState() => _AdminSignUpScreenState();
}

class _AdminSignUpScreenState extends State<AdminSignUpScreen> {

  final _contactNumberController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  @override
  void dispose() {                    // for memory management.practice dispose of all text editing controller?
    _contactNumberController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }


  final formkey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());         // to access controllers from sign up controller INDIAN


  String email = '';
  String password = '';


  // create user (might be similar to register user)
  Future signUp() async {
    if(passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
        ).then((value) {
          print('ACCOUNT CREATION SUCCESSFUL!');
          addAdminAccountDetails(_emailTextController.text.trim());
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminPreSignUpScreen()));
        });
    }
  }

  // authenticate if password typed is confirmed
  bool passwordConfirmed() {
    if (_passwordTextController.text.trim() == _confirmPasswordTextController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  // made method to add admin ACCOUNT details >> might need to locally put in AdminSignUpScreen [already there]
    Future addAdminAccountDetails(String email) async {
      final user = FirebaseAuth.instance.currentUser!;

      final String? uid;
      
      await FirebaseFirestore.instance.collection('Admins/${user.uid}/AdminDetails').add({
        // 'username' : username,
        'email' : email,
      });
    }

  // code for different way of authentication
  // final AuthService _auth = AuthService();      // add this to sinin_screen too later

  @override
  Widget build(BuildContext context) {
    
    
    
    return SafeArea(
        child: MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xffe7f9f9),
        body: Container(
          margin: const EdgeInsets.all(24),
                  child:Form(
          key: formkey,
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
    ));
  }

  Widget _header(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20,),
        Row(
          children: [
            // SizedBox(height:40),
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

        const SizedBox(height: 5,),


        const Text(
          "Create new account",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color(0xff8a8a8a),
          ),
        ),

        const SizedBox(height: 10,),
      ],
    );
  }

  _inputFields(context) {
    return Column(
      //key: _formkey,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Contact number",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff020003),
          ),
        ),
        
        TextFormField(
          validator: (value) => value?.isEmpty ?? true ? 'Invalid input' : null,
          // controller: controller.contactNumber,
          controller: _contactNumberController,
          obscureText: false,
          enableSuggestions: true,
          autocorrect: true,
          decoration: InputDecoration(
            hintText: "",
            fillColor: const Color(0xff83dbfe).withOpacity(0.5),
            filled: true,
            prefixIcon: const Icon(Icons.numbers_outlined),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
          ),
          // validator: (val) => val!.isEmpty ? 'Enter your contact number' : null,
          // onChanged: (val) {
          //   setState(() => contactNumber = val);
          // },
        ),


        const SizedBox(
          height: 15,
        ),


        const Text(
          "Email",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff020003),
          ),
        ),


        TextFormField(
          validator: (value) => value?.isEmpty ?? true ? 'Invalid input' : null,
          // controller: controller.email,
          controller: _emailTextController,
          obscureText: false,
          enableSuggestions: true,
          autocorrect: true,
          decoration: InputDecoration(
            hintText: "",
            fillColor: const Color(0xff83dbfe).withOpacity(0.5),
            filled: true,
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
          ),
          // validator: (val) => val!.isEmpty ? 'Enter your email' : null,
          // onChanged: (val) {
          //   setState(() => email = val);
          // },
        ),


        const SizedBox(
          height: 15,
        ),


        const Text(
          "Password",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff020003),
          ),
        ),
        TextFormField(
          validator: (value) => value?.isEmpty ?? true ? 'Invalid input' : null,
          // controller: controller.password,
          controller: _passwordTextController,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "",
            fillColor: const Color(0xff83dbfe).withOpacity(0.5),
            filled: true,
            prefixIcon: const Icon(Icons.password_outlined),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
          ),
          // validator: (val) => val!.isEmpty ? 'Enter your password' : null,
          // onChanged: (val) {
          //   setState(() => password = val);
          // },
        ),

        const SizedBox(height: 15,),

        const Text(
          "Confirm Password",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xff020003),
          ),
        ),
        TextFormField(
          validator: (value) => value?.isEmpty ?? true ? 'Invalid input' : null,
          // controller: controller.confirmPassword,
          controller: _confirmPasswordTextController,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "",
            fillColor: const Color(0xff83dbfe).withOpacity(0.5),
            filled: true,
            prefixIcon: const Icon(Icons.password_outlined),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
          ),
          // validator: (val) => val!.isEmpty ? 'Please confirm password' : null,
          // onChanged: (val) {
          //   setState(() => confirmPassword = val);
          // },
        ),


        const SizedBox(
          height: 15,
        ),


        ElevatedButton(
          onPressed: () async {
            //if (_formkey.currentState!.validate())
            if (formkey.currentState!.validate()){
              //  dynamic result = await _auth.registerWithEmailAndPassword(
              //         email: _emailTextController.text,
              //         password: _passwordTextController.text,);

                      signUp();          // ###################### LATEST FROM ASIAN DUDE
                      
                      // print(result);

                      // addUserAccountDetails(          // currently not being saved on docu 23/06/23
                      //   _contactNumberController.text,
                      //   _emailTextController.text);
                      
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => PreAdminSignUpScreen())); // change back to Homescreen
              //   }).onError((error, stackTrace) {
              //     print("Error ${error.toString()}");
              // });

              // ################ SIGN UP METHOD BY INDIAN ###############
              // SignUpController.instance.registerUser(
              //   controller.email.text.trim(),
              //   controller.password.text.trim());

              final user = UserInfoModel(
              // last_name: controller.last_name.text.trim(),
              // first_name: controller.first_name.text.trim(),
              // middle_name: controller.middle_name.text.trim(),
              // name_extension: controller.name_extension.text.trim(),
              // gender: controller.gender.text.trim(),

              // contactNumber: controller.contactNumber.text.trim(),
              contactNumber: _contactNumberController.text.trim(),

              // email: controller.email.text.trim(),
              email: _emailTextController.text.trim(),

              // password: controller.password.text.trim(),
              password: _passwordTextController.text.trim()

              // confirmPassword: controller.password.text.trim(),

              );
              // SignUpController.instance.createUser(user);
              }
          },


          child: const Text(
            "Sign Up",
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
    );
  }
}