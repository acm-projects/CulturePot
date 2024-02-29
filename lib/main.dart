import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import './utils.dart';
import '../services/firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: 'AIzaSyABHTakeXo6w5LCmwH-KdaqxskI8uWmIbc',
          appId: '1:174167442960:android:8971f3c6550c59282f2c95',
          messagingSenderId: '174167442960',
          projectId: 'culture-p',
        ))
      : await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      home: AuthenticationExample(),
    );
  }
}

class AuthenticationExample extends StatefulWidget {
  @override
  _AuthenticationExampleState createState() => _AuthenticationExampleState();
}

class _AuthenticationExampleState extends State<AuthenticationExample> {
  bool _userIsLoggedIn = false; // Tracks the user's login status

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Future.delayed(Duration(seconds: 2)), // Placeholder for future work
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          // Assuming user authentication status is checked in authsystem.dart
          if (_userIsLoggedIn) {
            return MyHomePage();
          } else {
            return SignupPage(onSignedIn: () {
              setState(() {
                _userIsLoggedIn = true;
              });
            });
          }
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class SignupPage extends StatelessWidget {
  final VoidCallback onSignedIn;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  SignupPage({required this.onSignedIn});

  Future<void> _signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // If signup successful, invoke callback to notify parent widget
      onSignedIn();
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(),
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Enter min 6 characters'
                    : null,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to login page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text("I already have an account"),
                  ),
                  ElevatedButton(
                    onPressed: _signUp,
                    child: Text("Create an account"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signIn() async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // If login successful, navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: Colors.grey[10],
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.grey[10],
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: _signIn,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            GestureDetector(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                ),
              ),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ForgetPasswordPage(),
              )),
            ),
            SizedBox(height: 16),
            Text("Don't have an account?"),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignupPage(onSignedIn: () {})),
                );
              },
              child: Text("Signup"),
            ),
            ElevatedButton(
              onPressed: () {
                /** Here you would place your Authentication System Code */
              },
              child: Text("sign in as guest"),
            )
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // text controller

  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();

  void openPostBox({String? docID}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: TextField(
                controller: textController,
              ),
              actions: [
                // button to save
                ElevatedButton(
                  onPressed: () {
                    // add a new
                    if (docID == null) {
                      firestoreService.addPost(textController.text);
                    } else {
                      firestoreService.updatePost(docID, textController.text);
                    }

                    // clear the text controller
                    textController.clear();

                    // close the box
                    Navigator.pop(context);
                  },
                  child: Text("Add"),
                )
              ],
            ));
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      //signout button
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              signOut();
            },
            child: Icon(Icons.logout_rounded),
            backgroundColor: Colors.green,
          ),
          SizedBox(height: 16), // Add some space between the buttons
          FloatingActionButton(
            onPressed: openPostBox,
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getPostsStream(),
        builder: (context, snapshot) {
          // if we have data, get all the docs
          if (snapshot.hasData) {
            List postsList = snapshot.data!.docs;

            // display as a list
            return ListView.builder(
                itemCount: postsList.length,
                itemBuilder: (context, index) {
                  // get each individual doc
                  DocumentSnapshot document = postsList[index];
                  String docID = document.id;

                  // get node from each doc
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String postText = data['post'];

                  // display as a list tile
                  return ListTile(
                      title: Text(postText),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // update button
                          IconButton(
                            onPressed: () => openPostBox(docID: docID),
                            icon: const Icon(Icons.settings),
                          ),

                          IconButton(
                            onPressed: () => firestoreService.deletePost(docID),
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ));
                });
          } else {
            return const Text("No posts...");
          }
        },
      ),

      // this body displays the email that is signed in
      /* 
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Signed in as',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              user!.email ?? 'null',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ), */
    );
  }
}

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text('Reset Password'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Receive an email to\nreset your password .',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  cursorColor: Colors.white,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: 'Email'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                  ),
                  icon: Icon(Icons.email_outlined),
                  label: Text(
                    'Reset Password',
                    style: TextStyle(fontSize: 24),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

  Future verifyEmail() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      Utils.showSnackBar('Password Reset Email Sent');
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }
}
