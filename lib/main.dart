import 'dart:typed_data';

import 'package:culture_pot/firebase_options.dart';
import 'package:culture_pot/pages/edit_profile_page.dart';
import 'package:culture_pot/pages/empty_preferences.dart';
import 'package:culture_pot/pages/home.dart';
import 'package:culture_pot/pages/login_page.dart';
import 'package:culture_pot/pages/notifsempty_page.dart';
import 'package:culture_pot/pages/preferencesPick_page.dart';
import 'package:culture_pot/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => LoginPage(), // signUp as the initial route
        '/preferences': (context) => MyPreferences(), // SignUpPage route
        '/success': (context) => SignSuccess(), // successPage route
        '/emptypreferences': (context) =>
            MyEmptyPreferences(), //emptyPreferences route
        '/notifications': (context) => MyNotifsEmpty(),
        '/editProfile': (context) => MyEditProfile(),
        '/home': (context) => MyHome(),
      },
    );
  }
}


/* 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return MyHomePage();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }

          return LoginPage();
        },
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
  final TextEditingController cultureController = TextEditingController();
  Uint8List? _file;
  String photoUrl = "";
  String uid = "";
  String username = "";
  bool _isLoading = false;


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
            _isLoading ? const LinearProgressIndicator() : Container(),

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

  signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 16), // Add space between the buttons
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedScreen()),
              );
            },
            child: Text('Feed Posts'),
          ),
          SizedBox(height: 16), // Add space between the buttons
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CulturePage()),
              );
            },
            child: Text('Culture List'),



          ),
                    SizedBox(height: 16), // Add space between the buttons
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CultureEntry()),
              );
            },
            child: Text('Cultures'),
          ),

          SizedBox(height: 16), // Add space between the buttons
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CulturePhrasebookEntryPage()),
              );
            },
            child: Text('Culture phrasebook'),
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
    );
  }
}


*/ 