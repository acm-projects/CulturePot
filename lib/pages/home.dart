import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/pages/make_post.dart';
import 'package:culture_pot/pages/preferences_page.dart';
import 'package:culture_pot/pages/post_screen.dart';
import 'package:culture_pot/pages/search_page.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:culture_pot/pages/notifsempty_page.dart';
import 'package:culture_pot/components/post.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<String> friendsUIDs = [];
  List<String> preferences = [];

  @override
  void initState() {
    super.initState();
    // Fetch friends UIDs when the page is loaded
    fetchFriendsUIDs();
    fetchUserPreferences();
  }

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
        print('Friends: $friends');
        setState(() {
          friendsUIDs = friends;
        });
      }
    }
  }

  Future<void> fetchUserPreferences() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (userSnapshot.exists) {
        final List<String> userPrefs = List<String>.from(userSnapshot.data()![
            'preferences']); // Assuming 'preferences' is the key for the preferences list
        print('Preferences: $userPrefs');
        setState(() {
          preferences = userPrefs;
        });
      }
    }
  }

  int _selectedIndex = 0;

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
                    break;
                  case 2:
                    Navigator.of(context).push(PageTransition(
                        child: MyHome(), type: PageTransitionType.fade));
                    break;
                  case 3:
                    Navigator.of(context).push(PageTransition(
                        child: UserProfilePage(),
                        type: PageTransitionType.fade));
                    break;
                }
              });
            },
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 230, 230),
        title: Image.asset('imagespot/logo.png', height: 90),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9.0),
          child: IconButton(
            onPressed: () => Navigator.of(context).push(PageTransition(
                child: MyNotifsEmpty(), type: PageTransitionType.fade)),
            icon: const Icon(
              Icons.favorite_border_rounded,
              size: 35.0,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MySearchPage()));
                },
                icon: const Icon(Icons.search_rounded,
                    color: Colors.black, size: 35.0)),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('posts').snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
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

                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    print('No posts available');
                    return Center(
                      child: Text('No posts available.'),
                    );
                  }

                  // Print out the contents of snapshot.data!.docs
                  print('Documents in collection:');
                  snapshot.data!.docs.forEach((doc) {
                    print(doc.data());
                  });

                  // Filter posts made by friends
                  final List<DocumentSnapshot> friendPosts = snapshot.data!.docs
                      .where((post) => friendsUIDs.contains(post.data()['uid']))
                      .toList();

                  print('Friend Posts: $friendPosts');

                  final List<DocumentSnapshot> culturePosts =
                      snapshot.data!.docs.where((post) {
                    // Retrieve the culture value from the post
                    String culture = post.data()['culture'];

                    // Check if the culture value is included in the user's preferences
                    return preferences.contains(culture);
                  }).toList();

                  print('Culture Posts: $culturePosts');

                  // Combine friendPosts and culturePosts into a single Set
                  Set<DocumentSnapshot> combinedPosts = {};

                  // Add friendPosts to the combined set
                  //combinedPosts.addAll(snapshot.data!.docs.where(
                  //    (post) => friendsUIDs.contains(post.data()['uid'])));

                  // Add culturePosts to the combined set
                  combinedPosts.addAll(snapshot.data!.docs.where((post) {
                    String culture = post.data()['culture'];
                    return preferences.contains(culture);
                  }));

                  // Convert the combined set back to a list
                  List<DocumentSnapshot> combinedList = combinedPosts.toList();

                  print('Combined Posts: $combinedList');

                  // Display posts
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: combinedList.length, // Use combinedList length
                    itemBuilder: (context, index) {
                      return PostScreen(
                        snap: combinedList[index]
                            .data(), // Access each post from combinedList
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MakePost(),
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 247, 192, 25),
        child: const Icon(Icons.add),
        shape: const CircleBorder(), // Make the button circular
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
        // No need to navigate to the same page
        break;
      case 1:
        // Navigate to Cultures page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PreferencesPage(),
          ),
        );
        break;
      case 2:
        // Navigate to Map page
        // Replace PreferencesPage with your desired page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PreferencesPage(),
          ),
        );
        break;
      case 3:
        // Navigate to Profile page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserProfilePage(),
          ),
        );
        break;
      default:
    }

    // Update tab color after navigation
    setState(() {
      _selectedIndex = index;
    });
  }
}
