import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onTap; // Define onTap property

  const SaveButton({
    Key? key,
    required this.isSaved,
    required this.onTap, // Pass onTap as a parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 6,
      child: IconButton(
        icon: Icon(
          isSaved ? Icons.bookmark : Icons.bookmark_border,
          color: isSaved ? Colors.black : Colors.black,
          size: 28,
        ),
        onPressed: onTap, // Call onTap callback on press
      ),
    );
  }
}
