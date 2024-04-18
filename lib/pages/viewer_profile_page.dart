import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/pages/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/post.dart';
import 'preferences_page.dart'; // Import the PreferencesPage
// ignore: depend_on_referenced_packages
import 'package:google_nav_bar/google_nav_bar.dart';
import 'home.dart';

class ViewerProfilePage extends StatefulWidget {
  final String uid;

  const ViewerProfilePage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  _ViewerProfilePageState createState() => _ViewerProfilePageState();
}

class _ViewerProfilePageState extends State<ViewerProfilePage> {
  int _selectedIndex = 0;
  bool _isPartnersClicked = false;

  String username = "";
  String bio = "";
  String email = "";
  String photoUrl = "";
  List friendsUIDs = [];
  int numFriends = 0;
  String numFriendsString = ""; // Define numFriendsString variable as a string
  List<String> preferences = [];

  Map<String, String> dictionary = {
    'Mexican': '🇲🇽',
    'Indian': '🇮🇳',
    'Eritrean': '🇪🇷',
    'France': '🇫🇷',
    'Japanese': '🇯🇵',
    'Nigerian': '🇳🇬',
    'China': '🇨🇳',
    'Thailand': '🇹🇭',
    'German': '🇩🇪',
  };

  Map<String, String> filterDictionary(
      List<String> preferences, Map<String, String> dictionary) {
    Map<String, String> filteredDictionary = {};
    for (var preference in preferences) {
      if (dictionary.containsKey(preference)) {
        filteredDictionary[preference] = dictionary[preference]!;
      }
    }
    return filteredDictionary;
  }

  Future<void> fetchPreferences(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (userSnapshot.exists) {
      final List<String> userPreferences = List<String>.from(userSnapshot
              .data()![
          'preferences']); // Assuming 'preferences' is the key for the preferences list
      setState(() {
        preferences = userPreferences;
      });
    }
  }

  void getBio() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid) // Use the uid variable here
        .get();

    print("Snapshot data: ${snap.data()}"); // Add this debug print statement

    setState(() {
      bio = (snap.data()
          as Map<String, dynamic>)['bio']; // Assign to the bio variable
    });
  }

  void getEmail() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    print("Snapshot data: ${snap.data()}"); // Add this debug print statement

    setState(() {
      String fullEmail = (snap.data()
          as Map<String, dynamic>)['email']; // Get the full email address
      email = fullEmail.split('@').first; // Extract the part before '@'
    });
  }

  Future<void> fetchFriendsUIDs(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
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
      numFriendsString = numFriends.toString() +
          " "; // Convert numFriends to string and concatenate with a space
    });
  }

  void getPhotoUrl() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    setState(() {
      photoUrl = (snap.data() as Map<String, dynamic>)['photoUrl'];
    });
  }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid)
        .get();

    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }

  @override
  void initState() {
    super.initState();
    getBio();
    fetchFriendsUIDs(widget.uid);
    getPhotoUrl();
    getUsername();
    fetchPreferences(widget.uid).then((_) {
      dictionary = filterDictionary(preferences, dictionary);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              backgroundImage: NetworkImage(
                                photoUrl,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isPartnersClicked = !_isPartnersClicked;
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: _isPartnersClicked
                                    ? Colors.white
                                    : Colors.orange[300],
                                side: const BorderSide(color: Colors.black),
                              ),
                              child: Text(
                                _isPartnersClicked ? 'Partners' : 'Add partner',
                                style: TextStyle(
                                  color: _isPartnersClicked
                                      ? Colors.black
                                      : Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: 10), // Add some space to move the row down
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
                      Text(
                        username,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '@' + email,
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
                          Text(
                            " Partners",
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
                          Row(
                            children: dictionary.values
                                .map((emoji) => Text(
                                      emoji,
                                      style: TextStyle(color: Colors.black),
                                    ))
                                .toList(),
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
                      // const SizedBox(height: 12),
                      //Post(),
                      // const SizedBox(height: 12),
                      //Post(),

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

                          final List<DocumentSnapshot> userPosts = snapshot
                              .data!.docs
                              .where((post) =>
                                  post.data()['uid'] ==
                                  widget.uid) // Filter based on UID
                              .toList();

                          return Column(
                            children: userPosts
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
                                      child: Post(
                                        pfp: (doc.data() as Map<String,
                                                dynamic>)['profImage'] ??
                                            '',
                                        likes: (doc.data() as Map<String,
                                                dynamic>)['likes'] ??
                                            '',
                                        username: (doc.data() as Map<String,
                                                dynamic>)['username'] ??
                                            '', // Provide default value if null
                                        imageUrl: (doc.data() as Map<String,
                                                dynamic>)['postUrl'] ??
                                            '', // Provide default value if null
                                        description: (doc.data() as Map<String,
                                                dynamic>)['description'] ??
                                            '', // Provide default value if null
                                        isLiked: (doc.data() as Map<String,
                                                dynamic>)['isLiked'] ??
                                            false, // Provide default value if null
                                        isSaved: (doc.data() as Map<String,
                                                dynamic>)['isSaved'] ??
                                            false, // Provide default value if null
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your logic to navigate to the screen where users can add a post
          // For example:
          // Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostScreen()));
        },
        backgroundColor: Color.fromARGB(255, 247, 192, 25),
        child: Icon(Icons.add),
        shape: CircleBorder(), // Make the button circular
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  icon: Icons.location_on_outlined, text: 'Map', iconSize: 30),
              GButton(
                  icon: Icons.person_outline, text: 'Profile', iconSize: 30),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
              navigateToPage(index);
            },
          ),
        ),
      ),
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
