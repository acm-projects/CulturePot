import 'package:flutter/material.dart';
//import 'package:culture_pot/pages/edit_profile_page.dart';
import 'package:culture_pot/components/post_textField.dart';

class MakePostText extends StatelessWidget {
  final String profileImageAsset;
  const MakePostText({
    Key? key,
    required this.profileImageAsset,
  }) : super(key: key); // Add constructor

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20), // Adding space above comments

            PostText(
              controller: TextEditingController(), // Example controller
              hintText: 'Interact!',
              obscureText: false,
              focusNode: FocusNode(),
            ),

            const SizedBox(height: 20), // Adding space below comments
          ],
        ),
      ),
    );
  }
}
