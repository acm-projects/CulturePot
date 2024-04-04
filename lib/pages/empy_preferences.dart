import 'package:culture_pot/pages/notifsempty_page.dart';
import 'package:culture_pot/pages/preferences_page.dart';
import 'package:culture_pot/pages/viewer_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyEmptyPreferences extends StatelessWidget {
  const MyEmptyPreferences({super.key});
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
          ),
        ),
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
                'lib/images/emptyPref.png',
                height: 160,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Empty",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Times',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Start Building your Culture preference list by saving inspiring cultures and experiences  ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter-Regular',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

