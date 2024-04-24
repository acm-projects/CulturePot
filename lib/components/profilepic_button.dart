import 'dart:typed_data';
import 'package:flutter/material.dart';

class MyProfileButton extends StatefulWidget {
  final Function()? onTap;
  final Uint8List? image; // Declare the image here

  const MyProfileButton({Key? key, required this.onTap, this.image})
      : super(key: key);

  @override
  _MyProfileButtonState createState() => _MyProfileButtonState();
}

class _MyProfileButtonState extends State<MyProfileButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 50, // Consistent size
          backgroundColor: Colors.grey.shade200,
          child: CircleAvatar(
            radius: 45, // Slightly smaller to create a border effect
            backgroundImage: widget.image != null
                ? MemoryImage(widget.image!) // Use the image from the widget
                : AssetImage('images/default.png') as ImageProvider,
          ),
        ),
        Positioned(
          bottom: 1,
          right: 1,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                color: Colors.white,
                width: 0.1,
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 4),
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 3,
                ),
              ],
            ),
            child: IconButton(
              onPressed: widget.onTap, // Use widget.onTap directly
              icon: Icon(Icons.add_a_photo),
              iconSize: 30,
            ),
          ),
        ),
      ],
    );
  }
}