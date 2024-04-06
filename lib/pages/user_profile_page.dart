import 'package:culture_pot/components/preference_card.dart';
import 'package:culture_pot/pages/edit_profilepage.dart';
import 'package:culture_pot/pages/empy_preferences.dart';
import 'package:culture_pot/pages/homepage.dart';
import 'package:culture_pot/pages/notifsempty_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/post.dart';
import 'preferences_page.dart'; // Import the PreferencesPage
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';
import 'package:culture_pot/pages/friends_listpage.dart';
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  int _selectedIndex = 3;

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
                });
            },
            
          ),
        ),
      ),
      
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
                    'lib/images/taj.png',
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
                              backgroundImage:
                                  AssetImage('lib/images/pfpReal.jpeg'),
                            ),
                            TextButton(
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ), // Add some space to move the row down
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
                      const Text(
                        'Your Name',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '@username',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                        
                          TextButton(
                            onPressed: (){ Navigator.of(context).push(PageTransition(
                            child: FriendsList(),
                            type: PageTransitionType.fade));
                            },
                            child: Text('48',
                            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black)),
                            style: ButtonStyle(alignment: Alignment.centerLeft,
                             tapTargetSize: MaterialTapTargetSize.shrinkWrap
                            ),               
                            ),
                          const Text(
                            'Partners',
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
                          const Text(
                            '🇮🇳🇯🇵🇮🇩',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bio example: Love to travel, eat, and learn! HMU for language lessons in Hindi or Spanish',
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
                      const SizedBox(height: 12),
                      Post(),
                      const SizedBox(height: 12),
                      Post(),
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
        backgroundColor: const Color.fromARGB(255, 247, 192, 25),
        child: const Icon(Icons.add),
        shape: const CircleBorder(), // Make the button circular
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}