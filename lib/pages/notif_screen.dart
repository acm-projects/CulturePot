import 'package:culture_pot/components/notification_comment.dart';
import 'package:culture_pot/pages/preferences_page.dart';
import 'package:culture_pot/pages/search_page.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyNotifScreen extends StatefulWidget {
  const MyNotifScreen({Key? key}) : super(key: key);

  @override
  State<MyNotifScreen> createState() => _MyNotifScreen();
}

class _MyNotifScreen extends State<MyNotifScreen> {
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
                  icon: Icons.location_on_outlined, text: 'Map', iconSize: 30),
              GButton(
                  icon: Icons.person_outline, text: 'Profile', iconSize: 30),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: navigateToPage,
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 230, 230),
        title: Image.asset('imagespot/logo.png', height: 90),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MySearchPage()),
                );
              },
              icon: const Icon(Icons.search_rounded,
                  color: Colors.black, size: 35.0),
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              NotifComment(
                commentText:
                    'Amazing pronunciation! Try rolling your R\'s on some of those.',
                profileImageAsset: "imagespot/pfpKenzo.jpeg",
                username: 'CelesteLee',
              ),
              // Other Notification widgets go here
            ],
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
        // No need to navigate to the same page
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
        // Navigate to your desired page
        // For example, MyMapPage
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UserProfilePage(),
          ),
        );
        break;
      default:
    }
  }
}
