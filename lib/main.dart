import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/blank_page.dart';
import 'package:culture_pot/culture_page.dart';
import 'package:culture_pot/culture_phrasebook.dart';
import 'package:culture_pot/culture_phraseboook_entry.dart';
import 'package:culture_pot/feed_screen.dart';
import 'package:culture_pot/firebase_options.dart';
import 'package:culture_pot/map.dart';
import 'package:culture_pot/services/culture_entry.dart';
import 'package:culture_pot/user_list';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:image_picker/image_picker.dart';
import './utils.dart';
import '../services/firestore.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'forgetPassword.dart';
import 'signupPage.dart';
import 'loginPage.dart';
import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp(MyApp());
  await DotEnv().load(fileName: '.env').then((_) {
    runApp(MyApp());
  }).catchError((e) {
    print('Error loading .env file: $e');
  });
}

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
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController textController = TextEditingController();
  final TextEditingController cultureController = TextEditingController();
  Uint8List? _file;
  String photoUrl = "";
  String uid = "";
  String username = "";
  bool _isLoading = false;

  // Method to post image
  void postImage(
    String uid,
    String username,
    String profImage,
    String culture,
  ) async {
    setState(() {
      _isLoading = true;
    });

    try {
      String res = await FirestoreService().addPost(
        textController.text,
        _file!,
        uid,
        username,
        profImage,
        culture,
      );

      if (res == "success") {
        showSnackBar('Posted!', context);
        setState(() {
          _isLoading = false;
        });
        clearImage();
      } else {
        showSnackBar(res, context);
        _isLoading = false;
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  // Method to get photo URL
  void getPhotoUrl() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
    });
  }

  // Method to get UID
  void getUid() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    setState(() {
      uid = (snap.data() as Map<String, dynamic>)['uid'];
    });
  }

  // Method to get username
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

  // Method to clear image
  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  // Method to select image
  _selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: [
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
              },
            ),
          ],
        );
      },
    );
  }

  // Method to open post box
  void openPostBox({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          children: [
            _isLoading ? const LinearProgressIndicator() : Container(),
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
                  hintText: 'Enter the culture',
                  border: InputBorder.none,
                ),
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 15,
              width: 15,
              child: AspectRatio(
                aspectRatio: 1,
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
          ElevatedButton(
            onPressed: () {
              if (docID == null) {
                postImage(uid, username, photoUrl, cultureController.text);
              } else if (cultureController.text == null) {
                postImage(uid, username, photoUrl, "none");
              } else {
                firestoreService.updatePost(docID, textController.text);
              }
              textController.clear();
              cultureController.clear();
              Navigator.pop(context);
            },
            child: Text("Add"),
          )
        ],
      ),
    );
  }

  // Method to sign out
  final FirebaseAuth auth = FirebaseAuth.instance;
  void signOut() async {
    await auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
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
          SizedBox(height: 16),
          FloatingActionButton(
            onPressed: openPostBox,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserListScreen()),
              );
            },
            child: Text('User List'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedScreen()),
              );
            },
            child: Text('Feed Posts'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CulturePage()),
              );
            },
            child: Text('Culture List'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CultureEntry()),
              );
            },
            child: Text('Cultures'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapWidget()),
              );
            },
            child: Text('View Map'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MapWidget()),
              );
            },
            child: Text('Bookmarks'),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getPostsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List postsList = snapshot.data!.docs;
            return ListView.builder(
              itemCount: postsList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = postsList[index];
                String docID = document.id;
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                String postText = data['post'];
                return ListTile(
                  title: Text(postText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => openPostBox(docID: docID),
                        icon: const Icon(Icons.settings),
                      ),
                      IconButton(
                        onPressed: () => firestoreService.deletePost(docID),
                        icon: const Icon(Icons.delete),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const Text("No posts...");
          }
        },
      ),
    );
  }
}
