import 'package:culture_pot/pages/homepage.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/preference_card.dart';
import 'package:culture_pot/pages/preference_info.dart'; // Import the page you want to navigate to
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';
class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    bottomNavigationBar: 
      Container(
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
            
            tabs: const[
              GButton(icon: Icons.home,
              iconSize: 30,
              text: 'Home'
              ),
              GButton(icon: Icons.book_outlined, 
              iconSize: 30,
              text: 'Cultures'),
              GButton(icon: Icons.location_on_outlined, 
              text: 'Map',
              iconSize: 30,),
              GButton(icon: Icons.person_outline, 
              text: 'Profile',iconSize: 30,),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index){
               setState(() {
                  _selectedIndex = index;
                });
             switch (index){
              case 0 : 
               Navigator.of(context).push(PageTransition(
                child: MyHome(),
                type: PageTransitionType.fade));
              break;
              case 1: 
              Navigator.of(context).push(PageTransition(
                child: PreferencesPage(),
                type: PageTransitionType.fade));
              case 2: 
              Navigator.of(context).push(PageTransition(
                child: MyHome(),
                type: PageTransitionType.fade));
              case 3:
              Navigator.of(context).push(PageTransition(
                child: UserProfilePage(),
                type: PageTransitionType.fade));
              }
            },
            
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const PreferenceInfo()), // Navigate to the preference_info.dart page
          );
        },
        child: Preference(), // No need to wrap with GestureDetector
      ),
    );
  }
}