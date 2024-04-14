import 'package:flutter/material.dart';
import 'package:culture_pot/pages/edit_profile_page.dart';
import 'package:culture_pot/components/post_textField.dart';

class MakePost extends StatelessWidget {
  const MakePost({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 230, 230),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back, // Back arrow icon
            color: Colors.black, // Set the arrow color to black
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyEditProfile(),
                ),
              );
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.orange[300],
            ),
            child: const Text(
              'Share!',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Adding space above comments

              PostText(
                controller: TextEditingController(), // Example controller
                hintText: 'Share something!',
                obscureText: false,
                focusNode: FocusNode(),
              ),

              const SizedBox(height: 20), // Adding space below comments
            ],
          ),
        ),
      ),
    );
  }
}
