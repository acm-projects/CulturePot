import 'package:culture_pot/pages/login_page.dart';
import 'package:culture_pot/pages/user_profile_page.dart';
import 'package:culture_pot/pages/preference_info.dart';
// Import the ProfilePage

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: LoginPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/profile': (context) => const UserProfilePage(),
        '/preference': (context) => const PreferenceInfo(),
      },
    );
  }
}
