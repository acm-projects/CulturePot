// ignore: file_names
import 'package:flutter/material.dart';

class MyEditProfileButt extends StatelessWidget {
  final Function()? onTap;
  const MyEditProfileButt({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          backgroundColor: Color.fromARGB(255, 247, 192, 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(double.infinity, 30), // Set the minimum size
        ),
        child: const Text(
          "Save",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black,
            fontFamily: 'Inter-Regular',
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
