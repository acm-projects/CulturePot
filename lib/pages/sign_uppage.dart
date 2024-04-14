import 'package:culture_pot/components/my_button2.dart';
import 'package:culture_pot/components/my_textfield.dart';
import 'package:culture_pot/pages/preferencesPick_page.dart';
import 'package:culture_pot/services/auth_methods.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/my_button1.dart';
import 'package:culture_pot/pages/login_page.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final birthdayController = TextEditingController();

  void signUserUp(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MyPreferences(),
      ),
    );
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
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "   Sign Up!",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 31,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter-Regular',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "      Create your CulturePot account",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontFamily: 'Inter-Regular',
                    ),
                  ),
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
                  labelText: 'Date of Birth',
                  hintText: 'MM/DD/YYYY',
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
