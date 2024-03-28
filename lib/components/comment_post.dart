import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final String labelText;
  const Comment({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
                color: Color.fromARGB(255, 247, 192, 25), width: 1.0),
          ),
          fillColor: Colors.white,
          filled: true,
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontFamily: 'Inter-Regular',
            fontSize: 18,
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
