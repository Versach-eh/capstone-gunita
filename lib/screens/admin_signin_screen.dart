// NEEDS FIXING
// obscure password not working
// not exlusive to admin sign in. will take user log in too



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gunita20/screens/admin_signup_screen.dart';
import 'package:gunita20/screens/forgot_password.dart';
import 'package:gunita20/screens/home_screen.dart';


class AdminSignInScreen extends StatefulWidget {
  const AdminSignInScreen({super.key});
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void dispose() {                    // for memory management.practice dispose of all text editing controller?
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailTextController.text.trim(), 
      password: _passwordTextController.text.trim(),
      ).then((value) { 
       print('Sign in succesful!!!!!!!!!!!!!!!');
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                  const HomeScreen()), (Route<dynamic> route) => false);
  }).onError((error, stackTrace) {
    print('Error ${error.toString()}');
  });
  }

  

  final formkey = GlobalKey<FormState>();
  bool isPasswordHidden = true;

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
      ),
    );
  }

  Widget _header(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          SizedBox(
            width: 50,
            height: 50,
            child: IconButton(
              icon: Image.asset('assets/images/arrow_back.png'),
              onPressed: () {
                Navigator.pop(context); // Return to the previous page
              },
            ),
          ),
        ]),
        const Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xff4f22cd),
          ),
        ),
        const SizedBox(height: 0),
        const Text(
          "Log in to continue",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Color(0xff8a8a8a),
          ),
        ),
      ],
    );
  }

  Widget _inputField(context) {
    // var isPasswordHidden; // created by quick fix
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Email",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color(0xff020003),
          ),
        ),
        TextFormField(
          // validator: (value) => value?.isEmpty ?? true ? 'Invalid input' : null,
          validator: (val) =>
                    val?.isEmpty ?? true ? 'Enter your email' : null,
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
            fillColor: const Color(0xff83dbfe).withOpacity(0.5),
          ),
          keyboardType: false
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
          // onChanged: (val) {
          //   setState(() => username = val);
          // },
        ),


        const SizedBox(height: 10),

        const Text(
          "Password",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.bold,
            color: Color(0xff020003),
          ),
        ),


        TextFormField(
          // validator: (value) => value?.isEmpty ?? true ? 'Invalid input' : null,
          // validator: (value) => value!.isEmpty ? 'Invalid input' : null,
          
          controller: _passwordTextController,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: InputDecoration(
            hintText: "Enter Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color(0xff83dbfe).withOpacity(0.5),
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
          validator: (val) =>
                    val?.isEmpty ?? true ? 'Enter your Password' : null,
          keyboardType: true
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
          onChanged: (val) {
            // setState(() => _passwordTextController.text = val);
          },
          // obscureText: isPasswordHidden,
        ),


        const SizedBox(height: 30),


        ElevatedButton(
          onPressed: () {                               // NEED TO FIX. ONNLY PUSH WHEN CORRECTLY LOGGED IN!
             
             if (formkey.currentState!.validate()){
              try {
                  signIn(); 
                  } on FirebaseAuthException catch (e) {
              print(e);
              showDialog(context: context, builder: (context) {     // pop up :print from terminal to actual screen
              return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
             }}
          },
          child: const Text(
            "LOGIN",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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

  Widget _forgotPassword(context) {
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute (builder: (context) => const ForgotPassword()),
        );
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff4f22cd),
        ),
      ),
    );
  }

  Widget _signup(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AdminSignUpScreen()),
            );
          },
          child: const Text(
            "Don't have an account? Sign Up",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff4f22cd),
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
