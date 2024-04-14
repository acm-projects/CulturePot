import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String labelText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
                color: Color.fromARGB(255, 247, 192, 25), width: 1.0),
          ),
          fillColor: const Color.fromARGB(255, 233, 230, 230),
          filled: true,
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black,
            fontFamily: 'Inter-Regular',
            fontSize: 18,
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
