import 'package:flutter/material.dart';

class MakePost extends StatelessWidget {
  const MakePost({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Add your share functionality here
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              textStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            child: const Text(
              'Share!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
