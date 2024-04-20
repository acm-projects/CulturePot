import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/comment_view.dart';
import 'package:culture_pot/components/comment_post.dart';
//import 'package:flutter/widgets.dart';
//import 'package:culture_pot/components/comment_sheet.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('imagespot/logo.png', height: 90),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Pop back when the back button is pressed
          },
        ),
      ),
      body: const CommentSheet(),
    );
  }
}

class CommentSheet extends StatefulWidget {
  const CommentSheet({super.key});

  @override
  State<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends State<CommentSheet> {
  String photoUrl = "";

  void getPhotoUrl() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
  }

  void initState() {
    super.initState();
    getPhotoUrl();
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

              Comment(
                controller: TextEditingController(), // Example controller
                hintText: 'Interact with @username',
                obscureText: false,
                focusNode: FocusNode(),
                photoUrl: photoUrl,
              ),

              ViewComment(
                commentText: "Another comment.",
                profileImageAsset: "imagespot/indiaFlag.png",
                username: 'vidurnangia',
              ),

              // Add more ViewComment widgets as needed
              ViewComment(
                commentText: "Another comment.",
                profileImageAsset: "imagespot/indiaFlag.png",
                username: 'vidurnangia',
              ),

              const SizedBox(height: 20), // Adding space below comments
            ],
          ),
        ),
      ),
    );
  }
}
