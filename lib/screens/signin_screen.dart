import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/forgot_password.dart';
import 'package:gunita20/screens/get_started.dart';
import 'package:gunita20/screens/home_screen.dart';
import 'package:gunita20/screens/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailTextController.text.trim(),
        password: _passwordTextController.text.trim(),
      );
      print('Sign in successful!');
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? 'An error occurred.';
      if (e.code == 'user-not-found') {
        errorMessage = 'Account does not exist.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email address.';
      }
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  final formkey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(), // Occupy the whole screen
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffF2F6FC), Color(0xffDBE9F7).withOpacity(0.8)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Make scaffold background transparent
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 15,),
                  _header(context),
                  const SizedBox(height: 15,),
                  _inputField(context),
                  _forgotPassword(context),
                  _signup(context),
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
        Row(children: [
          SizedBox(
            width: 65,
            height: 65,
            child: IconButton(
              icon: Image.asset('assets/images/arrow_back.png'),
              onPressed: () {
                 Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CoverPage()),
        );
              },
            ),
          ),
        ]),
        const Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 44,
            fontWeight: FontWeight.bold,
            fontFamily: 'Magdelin', // Set the font family
            color: Color(0xff4f22cd),
          ),
        ),
        const SizedBox(height: 0),
        const Text(
          "Log in to continue",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Magdelin',
            color: Color(0xff8a8a8a),
          ),
        ),
      ],
    );
  }

  Widget _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        const Text(
          "Email",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Magdelin',
            color: Color(0xff020003),
          ),
        ),
        TextFormField(
          validator: (val) => val?.isEmpty ?? true ? 'Enter your email' : null,
          controller: _emailTextController,
          obscureText: false,
          enableSuggestions: true,
          autocorrect: true,
          decoration: InputDecoration(
            hintText: "juandelacruz@gmail.com",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 168, 122, 255).withOpacity(0.3),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 10),
        const Text(
          "Password",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Magdelin',
            color: Color(0xff020003),
          ),
        ),
        TextFormField(
          controller: _passwordTextController,
          obscureText: isPasswordHidden,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "Enter Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color.fromARGB(255, 168, 122, 255).withOpacity(0.3),
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordHidden ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  isPasswordHidden = !isPasswordHidden;
                });
              },
            ),
          ),
          validator: (val) => val?.isEmpty ?? true ? 'Enter your Password' : null,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (val) {},
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: () {
            if (formkey.currentState!.validate()) {
              signIn();
            }
          },
          child: const Text(
            "LOGIN",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Magdelin-Bold',
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff4530B2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            minimumSize: const Size(230, 60),
          ),
        ),
      ],
    );
  }

  Widget _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgotPassword()),
        );
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(
          fontSize: 20,
          color: Color(0xff4530B2),
          fontWeight: FontWeight.bold,
          fontFamily: 'Magdelin',
        ),
      ),
    );
  }

  Widget _signup(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 45),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpScreen()),
            );
          },
          child: const Text(
            "Don't have an account? Sign Up",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              fontFamily: 'Magdelin-Bold',
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff4530B2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            minimumSize: const Size(280, 50),
          ),
        ),
      ],
    );
  }
}
