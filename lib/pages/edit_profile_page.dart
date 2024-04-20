import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:culture_pot/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/my_textfield.dart';
import 'package:culture_pot/components/edit_profile_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class MyEditProfile extends StatefulWidget {
  MyEditProfile({Key? key}) : super(key: key);

  @override
  _MyEditProfileState createState() => _MyEditProfileState();
}

class _MyEditProfileState extends State<MyEditProfile> {
  final editNameController = TextEditingController();
  final editUsernameController = TextEditingController();
  final editPasswordController = TextEditingController();
  final editBirthdayController = TextEditingController();
  String photoUrl = "";
  Uint8List? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    getPhotoUrl();
  }

  void editProfile() {}

  void getPhotoUrl() async {
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (snap.exists && snap.data() != null) {
        Map<String, dynamic> userData = snap.data() as Map<String, dynamic>;
        String url = userData['photoUrl'] as String? ?? '';
        setState(() {
          photoUrl = url;
        });
      } else {
        print("Document does not exist or lacks 'photoUrl' field.");
      }
    } catch (e) {
      print('Error fetching user photo URL: $e');
    }
  }

  Future<void> selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Uint8List imageData = await pickedFile.readAsBytes();
      setState(() {
        _image = imageData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 230, 230),
        title: const Text('Edit Profile'),
        leading: IconButton(
          onPressed: () => Navigator.of(context).push(PageTransition(
            child: UserProfilePage(),
            type: PageTransitionType.fade,
          )),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 92,
                    backgroundColor: Colors.grey.shade600,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.grey.shade800, // Fallback color
                     backgroundImage: _image != null
    ? MemoryImage(_image!)
    : (photoUrl.isNotEmpty
        ? NetworkImage(photoUrl)
        : AssetImage('assets/placeholder_image.jpg')), /
                    ),
                  ),
                  IconButton(
                    onPressed: selectImage,
                    icon: const Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              MyTextField(
                controller: editNameController,
                labelText: 'Your Name',
                hintText: 'Name',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: editBirthdayController,
                labelText: 'Edit Birthday',
                hintText: 'Birthday',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: editUsernameController,
                labelText: 'Edit Username',
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyTextField(
                controller: editPasswordController,
                labelText: 'Edit Password',
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 35),
              MyEditProfileButt(onTap: editProfile)
            ],
          ),
        ),
      ),
    );
  }
}
