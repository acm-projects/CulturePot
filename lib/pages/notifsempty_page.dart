//import 'package:culture_pot/pages/notifsempty_page.dart';
import 'package:culture_pot/pages/preferences_page.dart';
//import 'package:culture_pot/pages/viewer_profile_page.dart';
import 'package:flutter/material.dart';
//import 'package:page_transition/page_transition.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:culture_pot/pages/search_page.dart';
import 'package:culture_pot/pages/user_profile_page.dart';

class MyNotifsEmpty extends StatefulWidget {
  const MyNotifsEmpty({Key? key}) : super(key: key);

  @override
  State<MyNotifsEmpty> createState() => _MyNotifsEmptyState();
}

class _MyNotifsEmptyState extends State<MyNotifsEmpty> {
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
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 9.0),
          //   child: IconButton(
          //     onPressed: () => Navigator.of(context).push(
          //       PageTransition(
          //           child: MyNotifsEmpty(), type: PageTransitionType.fade),
          //     ),
          //     icon: const Icon(
          //       Icons.favorite_border_rounded,
          //       size: 35.0,
          //     ),
          //   ),
          // ),
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
            children: <Widget>[
              const SizedBox(
                height: 200,
              ),
              Image.asset(
                'lib/images/buzz.png',
                height: 170,
              ),
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "No Buzz!",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      fontFamily: 'Alike',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Text(
                    "You have no current notifications",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Alike',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 180),
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
            builder: (context) => const UserProfilePage(
              profileImageAsset: "imagespot/pfpReal.jpeg",
              username: '@newuser',
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
