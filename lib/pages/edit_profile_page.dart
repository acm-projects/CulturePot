import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/my_textfield.dart';
import 'package:culture_pot/components/edit_profile_button.dart';
import 'package:page_transition/page_transition.dart';

class MyEditProfile extends StatelessWidget {
  MyEditProfile({super.key});
  final editNameController = TextEditingController();
  final editUsernameController = TextEditingController();
  final editPasswordController = TextEditingController();
  final editBirthdayController = TextEditingController();
  void editProfile() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 233, 230, 230),
        title: const Text('Edit Profile'),
        leading: IconButton(
            onPressed: () => Navigator.of(context).push(PageTransition(
                child: const UserProfilePage(), type: PageTransitionType.fade)),
            icon: Icon(Icons.arrow_back)),
      ),
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),

              CircleAvatar(
                radius:
                    92, // Change this radius for the width of the circular border
                backgroundColor: Colors.grey.shade600,
                child: const CircleAvatar(
                  radius:
                      90, // This radius is the radius of the picture in the circle avatar itself.
                  backgroundImage: NetworkImage(
                      'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIzLTEwL3Jhd3BpeGVsX29mZmljZV8zNV9oYXBweV9ibGFja193b21hbl9zbWlsZXNfYXRfY2FtZXJhX2lzb2xhdGVkX182Nzc5ZmU0OC1lMmJiLTQxMmYtOGE3OC1jNzQ2ZmFmNjQxM2VfMS5qcGc.jpg'),
                ),
              ),

              const SizedBox(
                height: 50,
              ),
              //Your name Textfield
              MyTextField(
                controller: editNameController,
                labelText: 'Your Name',
                hintText: 'Name',
                obscureText: false,
              ),
              const SizedBox(
                height: 25,
              ),

              //write day of birth
              MyTextField(
                controller: editBirthdayController,
                labelText: 'Edit bio',
                hintText: 'Write new bio',
                obscureText: false,
              ),
              const SizedBox(
                height: 25,
              ),

              //create username text field
              MyTextField(
                controller: editUsernameController,
                labelText: 'Edit username',
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(
                height: 25,
              ),

              //retype password text field
              MyTextField(
                controller: editPasswordController,
                labelText: 'Edit password',
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(
                height: 35,
              ),
              MyEditProfileButt(onTap: editProfile)
            ],
          ),
        ),
      ),
    );
  }
}
