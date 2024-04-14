import 'package:flutter/material.dart';

class MyButton2 extends StatelessWidget {
  final Function()? onTap;
  const MyButton2({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          minimumSize: Size(double.infinity, 30), // Set the minimum size
        ),
        child: Text(
          "Sign up with Google",
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
