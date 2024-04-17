//import 'package:culture_pot/pages/notifsempty_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:culture_pot/components/post.dart';
import 'package:page_transition/page_transition.dart';
import 'package:culture_pot/pages/preferences_page.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:culture_pot/pages/notif_screen.dart';
import 'package:culture_pot/pages/post_screen.dart';
import 'package:culture_pot/pages/make_post.dart';
import 'package:culture_pot/pages/search_page.dart';
import 'package:culture_pot/pages/map.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
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
                icon: Icons.search,
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
                        child: Map(), type: PageTransitionType.fade));
                    break;
                  case 3:
                    Navigator.of(context).push(PageTransition(
                        child: const UserProfilePage(
                          profileImageAsset: "imagespot/pfpReal.jpeg",
                          username: '@user34',
                        ),
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
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              PageTransition(
                child: const MyNotifScreen(),
                type: PageTransitionType.fade,
              ),
            ),
            icon: const Icon(
              Icons.favorite_border_rounded,
              size: 35.0,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostScreen(),
                    ),
                  );
                },
                child: Post(
                  profileImageAsset: 'imagespot/pfpReal.jpeg',
                  username:
                      'dynamic_username', // Provide the dynamic username here
                  caption: 'My caption',
                  likedBy: 'vidurnangia',
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PostScreen(),
                    ),
                  );
                },
                child: Post(
                  profileImageAsset: 'imagespot/pfpReal.jpeg',
                  username:
                      'dynamic_username', // Provide the dynamic username here
                  caption: 'My caption',
                  likedBy: 'vidurnangia',
                ),
              ),
              const SizedBox(height: 12),
              Post(
                profileImageAsset: 'imagespot/pfpReal.jpeg',
                username:
                    'dynamic_username2', // Provide the dynamic username here
                caption:
                    'My family and I visited the Statue of Unity in Gujarat, India this spring for the first time. I was fascinated at the way the locals spoke dialect X of Gujarati while we tourists spoke and learned in dialect Y. Does anyone know why that is?',
                likedBy: 'hello',
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
        child: Icon(Icons.add),
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
            builder: (context) => const Map(),
          ),
        );
        break;
      case 3:
        // Navigate to Profile page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserProfilePage(
              profileImageAsset: "imagespot/pfpReal.jpeg",
              username: '@user344',
            ),
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
