import 'package:flutter/material.dart';

class MySearchPrefButton extends StatelessWidget {

  final Function() ? onTap;
  const MySearchPrefButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:25.0),
      child:  ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          backgroundColor: Color.fromARGB(255, 247, 192, 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
         minimumSize: Size(double.infinity, 120), // Set the minimum size
      
        ),
        child: Text(
          "Preferences",
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

class MySearchPrefButton2 extends StatelessWidget {

  final Function() ? onTap;
  const MySearchPrefButton2({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:25.0),
      child:  ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          backgroundColor: Color.fromARGB(255, 247, 192, 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
         minimumSize: Size(double.infinity, 120), // Set the minimum size
      
        ),
        child: Text(
          "Map",
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
class MySearchPrefButton3 extends StatelessWidget {

  final Function() ? onTap;
  const MySearchPrefButton3({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:25.0),
      child:  ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(10),
          backgroundColor: Color.fromARGB(255, 247, 192, 25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
         minimumSize: Size(double.infinity, 120), // Set the minimum size
      
        ),
        child: Text(
          "My Profile",
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