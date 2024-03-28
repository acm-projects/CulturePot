import 'package:culture_pot/components/preference_card.dart';
import 'package:culture_pot/pages/empy_preferences.dart';
import 'package:culture_pot/pages/homepage.dart';
import 'package:culture_pot/pages/notifsempty_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/post.dart';
import 'preferences_page.dart'; // Import the PreferencesPage
import 'package:google_nav_bar/google_nav_bar.dart';


class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _page = 0;

  final screens = [
    const MyNotifsEmpty(),
    const  MyHome(),
    const MyEmptyPreferences()
  ];
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
            activeColor: Colors.grey[600],
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
            selectedIndex: _page,
            onTabChange: (index){
               setState(() {
                  _page = index;
                });
            },
            
          ),
        ),
      ),
      
      appBar: AppBar(
        title: const Text('Your Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () {
                // Edit profile
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
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image for top 1/5 of the screen
          Positioned.fill(
            top: 0,
            child: FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: 1 / 6,
              child: Image.asset(
                'imagespot/taj.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 70),
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('imagespot/pfpReal.jpeg'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Your Name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Text(
                    '@username',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '48 ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text: 'Partners',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: '   ',
                        ),
                        TextSpan(
                          text: 'Preferences, ',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                        TextSpan(
                          text: '🇳🇬🇬🇭🇱🇷',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Bio example: Love to travel, eat, and learn! HMU for language lessons in Hindi or Spanish',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        // Navigate to PreferencesPage
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
                  const SizedBox(height: 2),
                  Post(),
                  const SizedBox(height: 12),
                  Post(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
