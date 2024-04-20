import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/comment_view.dart';
import 'package:culture_pot/components/comment_post.dart';
//import 'package:flutter/widgets.dart'; // Importing the Comment widget

class CommentFeet extends StatefulWidget {
  const CommentFeet({Key? key}) : super(key: key);

  @override
  State<CommentFeet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentFeet> {
  String photoUrl = "";

  void getPhotoUrl() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Adding space above comments

              /*
              Comment(
                controller: TextEditingController(), // Example controller
                hintText: 'Interact with @username',
                obscureText: false,
                focusNode: FocusNode(),
                photoUrl: photoUrl,
              ),
              */

              ViewComment(
                commentText: "This is a comment.",
                profileImageAsset: "imagespot/pfpKenzo.jpeg",
                username: '@vidurnangia',
              ),

              // Add more ViewComment widgets as needed
              ViewComment(
                commentText: "Another comment.",
                profileImageAsset: "imagespot/indiaFlag.",
                username: '@vidurnangia',
              ),

              const SizedBox(height: 20), // Adding space below comments
            ],
          ),
        ),
      ),
    );
  }
}
