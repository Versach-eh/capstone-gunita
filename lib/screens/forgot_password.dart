import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final TextEditingController _emailTextController = TextEditingController();

  @override
  void dispose() {                  // for memory management.practice dispose of all text editing controller?
    _emailTextController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailTextController.text.trim());
          showDialog(context: context, builder: (context) {     // pop up :print from terminal to actual screen
        return const AlertDialog(
          content: Text('Password reset link sent. Check your email.'),
        );
      });
          
          
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context, builder: (context) {     // pop up :print from terminal to actual screen
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff4f22cd),
        elevation: 0,
      ),
      body: Column(
        children: [

          const SizedBox(height: 10),

          const Text('Enter your email to receive your reset link',
          style: TextStyle(fontSize: 20),),

          
          const SizedBox(height: 10),


          TextFormField(
          // validator: (value) => value?.isEmpty ?? true ? 'Invalid input' : null,
          validator: (value) => value!.isEmpty ? 'Invalid input' : null,
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


        ElevatedButton(
          onPressed: () {
            passwordReset();
          },
          child: const Text(
            "Reset Password",
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
      )
    );
  }
}