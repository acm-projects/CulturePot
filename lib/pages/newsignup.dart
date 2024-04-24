import 'dart:typed_data';

import 'package:culture_pot/components/my_button2.dart';
import 'package:culture_pot/components/my_textfield.dart';
import 'package:culture_pot/components/profilepic_button.dart';
import 'package:culture_pot/pages/preferencesPick_page.dart';
import 'package:culture_pot/services/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/my_button1.dart';
import 'package:culture_pot/pages/login_page.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final birthdayController = TextEditingController();

  Uint8List _image = Uint8List(0);

  void signUserUp(BuildContext context) async {
    String res = await AuthMethods().signUpUser(
      username: nameController.text,
      bio: birthdayController.text,
      email: emailController.text,
      password: passwordController.text,
      file: _image!,
    );

    if (res == "success") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyPreferences(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(res)),
      );
    }
  }

  void selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = Uint8List(0); // Resetting to avoid build errors temporarily
      });
      setState(() async {
        _image = await image.readAsBytes();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'lib/images/SignIn.png',
                  height: 230,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "   Sign Up!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 31,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter-Regular',
                          ),
                        ),
                        const Text(
                          "      Create your CulturePot account",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Inter-Regular',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    MyProfileButton(
                      image: _image,
                      onTap: selectImage,
                    ),
                  ],
                ),
                const SizedBox(height: 17),
                MyTextField(
                  controller: nameController,
                  labelText: 'Your Name',
                  hintText: 'Name',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: birthdayController,
                  labelText: 'Bio',
                  hintText: 'Create your short bio...',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: emailController,
                  labelText: 'Create username',
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                MyTextField(
                  controller: passwordController,
                  labelText: 'Create password',
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                MyButton1(
                  onTap: () async {
                    // Create the account in Firebase
                    String res = await AuthMethods().signUpUser(
                      username: nameController.text,
                      bio: birthdayController.text,
                      email: emailController.text,
                      password: passwordController.text,
                      file: _image,
                    );
                    // Check if the account creation was successful
                    if (res == "success") {
                      // If successful, redirect the user to sign up
                      signUserUp(context);
                    } else {
                      // If not successful, display an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(res),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          "Or",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: 'Inter-Regular',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                MyButton2(
                  onTap: () => signUserUp(context),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: const Text(
                    "Already have an account? Log in!",
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontFamily: 'Inter-Regular',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
