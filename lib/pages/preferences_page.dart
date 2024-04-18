import 'package:flutter/material.dart';
import 'package:culture_pot/components/preference_card.dart';
import 'package:culture_pot/pages/preference_info.dart'; // Import the page you want to navigate to
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:culture_pot/pages/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  int _selectedIndex = 1;

  List<String> preferences = [];

  Map<String, String> dictionaryEmoji = {
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

  Map<String, String> dictionaryImage = {
    'Mexican': 'imagespot/mexicoFlag.png',
    'Indian': 'imagespot/indiaFlag.png',
    'Eritrean': 'imagespot/eritreaFlag.png',
    'France': 'imagespot/franceFlag.jpg',
    'Japanese': 'imagespot/japanFlag.jpg',
    'Nigerian': 'imagespot/nigeriaFlag.png',
    'China': 'imagespot/chinaFlag.jpg',
    'Thailand': 'imagespot/thailandFlag.jpg',
    'German': 'imagespot/germanFlag.png',
  };

  Future<void> fetchPreferences() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (userSnapshot.exists) {
        final List<String> userpreferences =
            List<String>.from(userSnapshot.data()!['preferences']);
        setState(() {
          preferences = userpreferences;
        });
      }
    }
  }

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

  @override
  void initState() {
    super.initState();
    fetchPreferences().then((_) {
      dictionaryEmoji = filterDictionary(preferences, dictionaryEmoji);
      dictionaryImage = filterDictionary(preferences, dictionaryImage);
    });
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
              });
              switch (index) {
                case 0:
                  Navigator.of(context).push(PageTransition(
                      child: MyHome(), type: PageTransitionType.fade));
                  break;
                case 1:
                  Navigator.of(context).push(PageTransition(
                      child: PreferencesPage(), type: PageTransitionType.fade));
                  break;
                case 2:
                  Navigator.of(context).push(PageTransition(
                      child: MyHome(), type: PageTransitionType.fade));
                  break;
                case 3:
                  Navigator.of(context).push(PageTransition(
                      child: UserProfilePage(), type: PageTransitionType.fade));
                  break;
              }
            },
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: ListView.builder(
        itemCount: dictionaryEmoji.length,
        itemBuilder: (context, index) {
          String preference = dictionaryEmoji.keys.elementAt(index);
          String emoji = dictionaryEmoji.values.elementAt(index);
          String imageUrl = dictionaryImage[preference] ?? '';

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PreferenceInfo(),
                ),
              );
            },
            child: Preference(
              photoUrl: imageUrl,
              name: '$preference $emoji',
            ),
          );
        },
      ),
    );
  }
}
