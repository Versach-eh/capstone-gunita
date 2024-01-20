import 'package:flutter/material.dart';

TextFormField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextFormField(
    validator: (value) => value!.isEmpty ? 'Invalid input' : null,
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.black,
    style: TextStyle(color: Colors.grey[900]),
    // decoration: InputDecoration(
    //   prefixIcon: Icon(
    //     icon,
    //     color: Colors.grey[900],
    //   ),
    //   labelText: text,
    //   labelStyle: TextStyle(color: Colors.grey[900]),
    //   filled: true,
    //   floatingLabelBehavior: FloatingLabelBehavior.never,
    //   fillColor: Colors.grey[300],
    //   border: OutlineInputBorder(
    //       borderRadius: BorderRadius.circular(18.0),
    //       borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    // )
    decoration: InputDecoration(
            hintText: text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color(0xff83dbfe).withOpacity(0.5),
          ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container signInSignUpButton(
    BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        isLogin ? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
      ),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.white;
            }
            return Colors.purple[900];
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}

//  Slider resusableSlider (_currentPieces) {                         potential slider for puzzle game
//           return Slider(
//             value: (_currentPieces ?? 100).toDouble(),
//             activeColor: Colors.brown[_currentPieces ?? 100],
//             inactiveColor: Colors.brown[_currentPieces ?? 100],
//             min: 100.0,
//             max: 900.0,
//             divisions: 8,
//             onChanged: (val) => setState(() => _currentPieces = val.round()),
//           );
//           }