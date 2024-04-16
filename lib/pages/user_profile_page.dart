import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/pages/login_page.dart';
import 'package:culture_pot/pages/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/post.dart';
import 'preferences_page.dart'; // Import the PreferencesPage
import 'package:page_transition/page_transition.dart';
import 'package:culture_pot/pages/edit_profile_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'home.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _selectedIndex = 3; // Added this line to define _selectedIndex

  String photoUrl = "";
  String uid = "";
  String username = "";
  String bio = "";
  List friendsUIDs = [];
  int numFriends = 0;
  String numFriendsString = ""; // Define numFriendsString variable as a string

  Future<void> fetchFriendsUIDs() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (userSnapshot.exists) {
        final List<String> friends = List<String>.from(userSnapshot.data()![
            'friends']); // Assuming 'friends' is the key for the friends list
        setState(() {
          friendsUIDs = friends;
        });
      }

      setState(() {
        numFriends = friendsUIDs
            .length; // Update numFriends with the length of friendsUIDs
      });

      setState(() {
        numFriendsString = numFriends.toString() +
            " "; // Convert numFriends to string and concatenate with a space
      });
    }
  }

  void getBio() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    print("Snapshot data: ${snap.data()}"); // Add this debug print statement

    setState(() {
      bio = (snap.data()
          as Map<String, dynamic>)['bio']; // Assign to the bio variable
    });
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
    getBio();
    fetchFriendsUIDs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color.fromARGB(255, 233, 230, 230),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15.0),
          child: GNav(
            backgroundColor: const Color.fromARGB(255, 233, 230, 230),
            color: Color.fromARGB(255, 247, 192, 25),
            activeColor: Colors.black,
            gap: 6,
            tabBackgroundColor: Color.fromARGB(167, 247, 192, 25),
            padding: EdgeInsets.all(12),
            tabs: const [
              GButton(icon: Icons.home, iconSize: 30, text: 'Home'),
              GButton(
                  icon: Icons.book_outlined, iconSize: 30, text: 'Cultures'),
              GButton(
                icon: Icons.location_on_outlined,
                text: 'Map',
                iconSize: 30,
              ),
              GButton(
                icon: Icons.person_outline,
                text: 'Profile',
                iconSize: 30,
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                switch (index) {
                  case 0:
                    Navigator.of(context).push(PageTransition(
                        child: MyHome(), type: PageTransitionType.fade));
                    break;
                  case 1:
                    Navigator.of(context).push(PageTransition(
                        child: PreferencesPage(),
                        type: PageTransitionType.fade));
                  case 2:
                    Navigator.of(context).push(PageTransition(
                        child: MyHome(), type: PageTransitionType.fade));
                  case 3:
                    Navigator.of(context).push(PageTransition(
                        child: UserProfilePage(),
                        type: PageTransitionType.fade));
                }
              });
            },
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 130.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'imagespot/taj.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(photoUrl),
                            ),
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
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ), // Add some space to move the row down
                    ],
                  ),
                ],
              ),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "@" + username,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            numFriendsString,
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          const Text(
                            'Partners',
                            style: TextStyle(color: Colors.black),
                          ),
                          const Text('   '),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PreferencesPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Preferences  ',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const Text(
                            '🇮🇳🇯🇵🇮🇩',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        bio,
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PreferencesPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Preferences',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // here are posts
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('posts')
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.hasError) {
                            print('Error: ${snapshot.error}');
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (snapshot.data == null ||
                              snapshot.data!.docs.isEmpty) {
                            print('No posts available');
                            return Center(
                              child: Text('No posts available.'),
                            );
                          }

                          final List<DocumentSnapshot> friendPosts = snapshot
                              .data!.docs
                              .where((post) =>
                                  friendsUIDs.contains(post.data()['uid']))
                              .toList();

                          print('Friend Posts: $friendPosts');

                          Set<DocumentSnapshot> combinedPosts = {};
                          combinedPosts.addAll(friendPosts);
                          List<DocumentSnapshot> combinedList =
                              combinedPosts.toList();

                          print('Combined Posts: $combinedList');

                          return Column(
                            children: combinedList
                                .map((doc) => GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PostScreen(
                                              snap: doc.data(),
                                            ),
                                          ),
                                        );
                                      },
                                      //child: Post(),
                                    ))
                                .toList(),
                          );
                        },
                      ),

                      const SizedBox(height: 12),
                      //Post(),
                      const SizedBox(height: 12),
                      //Post(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Icon(Icons.logout_rounded),
          ),
          SizedBox(
              height:
                  16), // Add some space between the Log out button and the Add button
          FloatingActionButton(
            onPressed: () {
              // Add your logic to navigate to the screen where users can add a post
              // For example:
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostScreen()));
            },
            backgroundColor: const Color.fromARGB(255, 247, 192, 25),
            child: const Icon(Icons.add),
            shape: const CircleBorder(), // Make the button circular
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHome(),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PreferencesPage(),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PreferencesPage(),
          ),
        );
        break;
      case 3:
        break;
      default:
    }
  }
}
