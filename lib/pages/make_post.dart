import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/feed_screen.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:culture_pot/services/firestore.dart';
import 'package:culture_pot/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/pages/edit_profile_page.dart';
import 'package:culture_pot/components/post_textField.dart';

class MakePost extends StatefulWidget {
  const MakePost({Key? key}) : super(key: key);

  @override
  _MakePostState createState() => _MakePostState();
}

// onPressed: () => openPostBox(docID: docID),

class _MakePostState extends State<MakePost> {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();
  final TextEditingController cultureController = TextEditingController();
  String photoUrl = "";
  String uid = "";
  String username = "";
  Uint8List? _file;

  String _currentText = "";

  void _updateText(String newText) {
    setState(() {
      _currentText = newText;
    });
  }

  String currentCulture = 'Nigerian';

  void updateCulture(String newCulture) {
    setState(() {
      currentCulture = newCulture; // Update the state when culture changes
    });
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    getPhotoUrl();
    getUid();
    getUsername();
  }

  void getPhotoUrl() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
    });
  }

  void getUid() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      uid = (snap.data() as Map<String, dynamic>)['uid'];
    });
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  void _onFileUploaded(Uint8List? file) {
    setState(() {
      _file = file;
    });
  }

  void postImage(
    String uid,
    String username,
    String profImage,
    String culture,
  ) async {
    // Printing values from text fields
    print('Text field value: ${textController.text}');
    print('Culture value: ${cultureController.text}');

    try {
      int numLikes = 0;
      String res = await FirestoreService().addPost(_currentText,
          _file ?? Uint8List(0), uid, username, profImage, culture, numLikes);

      if (res == "success") {
        showSnackBar('Posted!', context);
        clearImage();
      } else {
        showSnackBar(res, context);
        //_isLoading = false;
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

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
              postImage(uid, username, photoUrl, currentCulture);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfilePage(),
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
                controller: textController, // Use the initialized controller
                onFileUploaded: _onFileUploaded,
                hintText: 'Share something!',
                obscureText: false,
                focusNode: FocusNode(),
                onTextChanged: _updateText,
                onCultureSelected: updateCulture, // Pass the update function

                // photoUrl: photoUrl,
              ),

              const SizedBox(height: 20), // Adding space below comments
            ],
          ),
        ),
      ),
    );
  }
}
