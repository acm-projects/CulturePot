import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:culture_pot/components/duolingo_card.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:culture_pot/pages/preferences_page.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:culture_pot/pages/home.dart';

class PreferenceInfo extends StatefulWidget {
  const PreferenceInfo({Key? key}) : super(key: key);

  @override
  _PreferenceInfoState createState() => _PreferenceInfoState();
}

class _PreferenceInfoState extends State<PreferenceInfo> {
  int _selectedIndex = 1;

  _launchURL() async {
    const url = 'https://www.duolingo.com/course/hi/en/Learn-Hindi';
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(500),
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('imagespot/taj.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text('Preferences'),
              actions: [
                // IconButton(
                //   icon: const Icon(Icons.arrow_back),
                //   onPressed: () {
                //     Navigator.pop(context);
                //   },
                // ),
              ],
              bottom: const PreferredSize(
                preferredSize:
                    Size.fromHeight(30), // Adjust the height as needed
                child: Center(
                  child: Text(
                    'India',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.lightBlue[100],
          child: Column(
            children: [
              const SizedBox(height: 10),
              Duolingo(
                onTap: _launchURL,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 18.0),
                child: Text(
                  'Embark on a linguistic journey through India\'s rich cultural tapestry by learning its national language. From the lyrical poetry of Hindi to the intricate scripts of Sanskrit, delve into a world where language intertwines with history, tradition, and modernity',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14, // Adjust the font size
                    letterSpacing: 0.8, // Adjust the letter spacing
                    height: 1.5, // Adjust the line height
                  ),
                ),
              ),
            ],
          ),
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
                  Navigator.of(context).push(PageTransition(
                      child: MyHome(), type: PageTransitionType.fade));
                  break;
                case 1:
                  Navigator.of(context).push(PageTransition(
                      child: PreferencesPage(), type: PageTransitionType.fade));
                case 2:
                  Navigator.of(context).push(PageTransition(
                      child: MyHome(), type: PageTransitionType.fade));
                case 3:
                  Navigator.of(context).push(PageTransition(
                      child: const UserProfilePage(
                        profileImageAsset: "imagespot/pfpReal.jpeg",
                        username: '@prefInfoUser',
                      ),
                      type: PageTransitionType.fade));
              }
            },
          ),
        ),
      ),
    );
  }
}
