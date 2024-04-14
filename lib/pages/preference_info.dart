import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:culture_pot/components/duolingo_card.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:culture_pot/pages/preferences_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:culture_pot/pages/home.dart';

class PreferenceInfo extends StatefulWidget {
  const PreferenceInfo({Key? key}) : super(key: key);

  @override
  _PreferenceInfoState createState() => _PreferenceInfoState();
}

class _PreferenceInfoState extends State<PreferenceInfo> {
  int _selectedIndex = 0;

  _launchURL() async {
    const url = 'https://www.duolingo.com/course/hi/en/Learn-Hindi';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(500), // Set the height of the app bar
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('imagespot/taj.png'),
                  fit: BoxFit
                      .cover, // Cover the entire app bar area with the image
                ),
              ),
            ),
            AppBar(
              backgroundColor:
                  Colors.transparent, // Make the app bar transparent
              elevation: 0, // Remove the app bar shadow
              title: const Text('Preferences'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(
                        context); // Navigate back to the previous screen
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.lightBlue[100], // Set background color of the body
        child: Column(
          children: [
            const SizedBox(height: 10),
            // You can add additional content here
            Duolingo(
              onTap:
                  _launchURL, // Pass the _launchURL function to Duolingo widget
            ),

            const Text('      LEARN',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                )),
          ],
        ),
      ),
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
                  // Navigate to Cultures page
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserProfilePage(),
                    ),
                  );

                  break;
                default:
              }
            },
          ),
        ),
      ),
    );
  }
}
