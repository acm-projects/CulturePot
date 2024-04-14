import 'package:culture_pot/main.dart';
import 'package:culture_pot/services/auth_methods.dart';
import 'package:culture_pot/utils.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/my_text_field.dart';
import 'package:culture_pot/pages/home.dart';
import 'package:culture_pot/pages/sign_uppage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
    this.hintText = '',
    this.obscureText = false,
  }) : super(key: key);

  final String hintText;
  final bool obscureText;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController =
      TextEditingController(); // Add controller for the name field

      void loginUser() async {
    setState(() {
      _isLoading = true;
    });

    String res = await AuthMethods().loginUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if (res == "success") {
      //
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MyHome(),
        ),
      );
    } else {
      //
      
      print("hi im error");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.grey[300],
    body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            // Your existing widgets here
                          Align(
                alignment: Alignment.center,
                child: Image.asset('imagespot/SignUp.png'),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "  Sign in \u{1F36F}",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 60,
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "     Please login to continue",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: MyTextField(
                  controller: emailController, // Pass the name controller here
                  labelText: 'Your email',
                  hintText: 'email',
                  obscureText: false,
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: MyTextField(
                  controller:
                      passwordController, // Pass the name controller here
                  labelText: 'Password',
                  hintText: 'New password',
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUp(),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '         Don\'t have an account? ',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    const Text(
                      'Sign Up!',
                      style: TextStyle(
                        // turn blue on press, nonelevated button
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ElevatedButton(
      onPressed: () async {
  setState(() {
    _isLoading = true; // Set loading state
  });

  String res = await AuthMethods().loginUser(
    email: emailController.text,
    password: passwordController.text,
  );

  if (res == "success") {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => MyHome(),
      ),
    );
  } else {
    // Remove this print statement and handle the error accordingly
    print(res);
  }

  setState(() {
    _isLoading = false; // Reset loading state
  });
},

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        color: Colors.black, // Loading indicator
                      )
                    : const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            // Other widgets
          ],
        ),
      ),
    ),
  );
}
}
