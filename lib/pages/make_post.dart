import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/services/firestore.dart';
import 'package:culture_pot/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/pages/edit_profile_page.dart';
import 'package:culture_pot/components/post_textField.dart';
import 'package:image_picker/image_picker.dart';

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
  Uint8List? _file;
  String photoUrl = "";
  String uid = "";
  String username = "";
  // bool _isLoading = false;

  void postImage(
    String uid,
    String username,
    String profImage,
    String culture,
  ) async {
    //setState(() {
    //  _isLoading = true;
    //});

    // Printing values from text fields
    print('Text field value: ${textController.text}');
    print('Culture value: ${cultureController.text}');

    try {
      String res = await FirestoreService().addPost(
          textController.text, _file!, uid, username, profImage, culture);

      if (res == "success") {
        showSnackBar('Posted!', context);
        //setState(() {
        //  _isLoading = false;
        //});
        clearImage();
      } else {
        showSnackBar(res, context);
        //_isLoading = false;
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
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

  @override
  void initState() {
    super.initState();
    getPhotoUrl();
    getUsername();
    getUid();
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(title: const Text('Create a Post'), children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a photo"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.camera,
                );
                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                }),
          ]);
        });
  }

  void openPostBox({String? docID}) {
    //final User user = Provider.of<UserProvider>(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          // Adjust the layout as needed
          children: [
            /*
            TextField(
              controller: textController,
            ),
            */
            // _isLoading ? const LinearProgressIndicator() : Container(),

            // Add IconButton here
            CircleAvatar(
              backgroundImage: NetworkImage(photoUrl),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Write a caption...',
                  border: InputBorder.none,
                ),
                maxLines: 8,
              ),
            ),
            SizedBox(
              width: 80,
              child: TextField(
                controller: cultureController,
                decoration: const InputDecoration(
                  hintText: 'Enter the culture()',
                  border: InputBorder.none,
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 15, // Adjust the height as needed
              width: 15, // Adjust the width as needed
              child: AspectRatio(
                aspectRatio: 1, // Adjust the aspect ratio as needed
                child: _file != null
                    ? Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          ),
                        ),
                      )
                    : Container(),
              ),
            ),

            const Divider(),
            IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          ],
        ),
        actions: [
          // button to save
          ElevatedButton(
            onPressed: () {
              // add a new
              if (docID == null) {
                //firestoreService.addPost(textController.text);
                postImage(uid, username, photoUrl, cultureController.text);
              } else if (cultureController.text == null) {
                postImage(uid, username, photoUrl, "none");
              } else {
                firestoreService.updatePost(docID, textController.text);
              }

              // clear the text controller
              textController.clear();
              cultureController.clear();

              // close the box
              Navigator.pop(context);
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

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
