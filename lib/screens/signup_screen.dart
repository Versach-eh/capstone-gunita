import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gunita20/screens/pre_signup_screen.dart';
import 'package:gunita20/services/signup_controller.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:gunita20/screens/loading.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _contactNumberController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  final _contactNumberFormatter = MaskTextInputFormatter(
    mask: '0000-000-0000',
    filter: {"0": RegExp(r'[0-9]')},
  );

  bool _showPassword = false;

  @override
  void dispose() {
    _contactNumberController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }

  final formkey = GlobalKey<FormState>();
  final controller = Get.put(SignUpController());

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  bool isValidEmail(String value) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(value);
  }

  Future signUp() async {
    if (passwordConfirmed()) {
      final email = _emailTextController.text.trim();

      final methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (methods.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return Loading();
          },
        );

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: _passwordTextController.text.trim(),
        ).then((value) {
          print('ACCOUNT CREATION SUCCESSFUL!');
          addUserAccountDetails(email);
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PreSignUpScreen()));
        }).catchError((error) {
          print('Error creating account: $error');
          Navigator.pop(context); // Close the loading dialog
          // Show the email already in use prompt
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Email in Use'),
                content: Text('The email address is already in use. Please use a different email address.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the alert dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        });
      } else {
        print('Email is already in use.');
        // Show the email already in use prompt
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Email in Use'),
              content: Text('The email address is already in use. Please use a different email address.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the alert dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  bool passwordConfirmed() {
    return _passwordTextController.text.trim() == _confirmPasswordTextController.text.trim();
  }

  Future addUserAccountDetails(String email) async {
    final user = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('Users/${user.uid}/UserDetails').add({
      'email': email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffF2F6FC), Color(0xffDBE9F7).withOpacity(0.8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
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
    );
  }

  Widget _header(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
        const Text(
          "Welcome!",
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            fontFamily: 'Magdelin-Bold',
            color: Color(0xff4f22cd),
          ),
        ),
        const Text(
          "Create new account",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Magdelin',
            color: Color(0xff8a8a8a),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  Widget _inputFields(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _requiredFieldLabel("Contact number"),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your contact number';
            }
            if (!RegExp(r'^09\d{2}-\d{3}-\d{4}$').hasMatch(value)) {
              return 'Invalid contact number format. It should start with 09';
            }
            return null;
          },
          controller: _contactNumberController,
          inputFormatters: [_contactNumberFormatter],
          obscureText: false,
          enableSuggestions: true,
          autocorrect: true,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: "e.g., 0900-000-0000",
            fillColor: const Color.fromARGB(255, 168, 122, 255).withOpacity(0.3),
            filled: true,
            prefixIcon: const Icon(Icons.phone),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _requiredFieldLabel("Email"),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!isValidEmail(value)) {
              return 'Invalid email format';
            }
            if (value.length > 200) {
              return 'Email should have at most 200 characters';
            }
            return null;
          },
          controller: _emailTextController,
          obscureText: false,
          enableSuggestions: true,
          autocorrect: true,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "e.g., example@example.com",
            fillColor: const Color.fromARGB(255, 168, 122, 255).withOpacity(0.3),
            filled: true,
            prefixIcon: const Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _requiredFieldLabel("Password"),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            if (value.length < 8) {
              return 'Password must be at least 8 characters long';
            }
            return null;
          },
          controller: _passwordTextController,
          obscureText: !_showPassword,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "",
            fillColor: const Color.fromARGB(255, 168, 122, 255).withOpacity(0.3),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        _requiredFieldLabel("Confirm Password"),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != _passwordTextController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          controller: _confirmPasswordTextController,
          obscureText: !_showPassword,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "",
            fillColor: Color.fromARGB(255, 168, 122, 255).withOpacity(0.3),
            filled: true,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        ElevatedButton(
          onPressed: () async {
            if (formkey.currentState!.validate()) {
              signUp();
            }
          },
          child: const Text(
            "NEXT",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              fontFamily: 'Magdelin',
              color: Color(0xffffffff),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff4530B2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            minimumSize: const Size(280, 60),
          ),
        ),
      ],
    );
  }

  Widget _requiredFieldLabel(String label) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color(0xff020003),
            fontFamily: 'Magdelin',
          ),
        ),
        Text(
          " *",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
