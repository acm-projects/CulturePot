import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/blank_page.dart';
import 'package:culture_pot/firebase_options.dart';
import 'package:culture_pot/user_list';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import './utils.dart';
import '../services/firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'forgetPassword.dart';
import 'signupPage.dart';
import 'loginPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
  void initState() {
    super.initState();
    checkUserLoginStatus();
  }

  Future<void> checkUserLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      await FirebaseAuth.instance.authStateChanges().listen((User? user) {
        setState(() {
          _userIsLoggedIn = user != null;
        });
      });
    }
  }

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
            return SignupPage(onSignedIn: () async {
              setState(() {
                _userIsLoggedIn = true;
              });

              // Store user login status in shared preferences
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('isLoggedIn', true);
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
          SizedBox(height: 16), // Add space between the buttons
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserListScreen()),
              );
            },
            child: Text('User List'),
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
