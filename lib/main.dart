import 'package:culture_pot/pages/edit_profilepage.dart';
import 'package:culture_pot/pages/empy_preferences.dart';
import 'package:culture_pot/pages/homepage.dart';
import 'package:culture_pot/pages/login_page.dart';
import 'package:culture_pot/pages/notifsempty_page.dart';
import 'package:culture_pot/pages/sign_uppage.dart';
import 'package:culture_pot/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/pages/preferencesPick_page.dart';
void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => LoginPage(),
        '/signup': (context) => SignUp(), // signUp as the initial route
        '/preferences': (context) => MyPreferences(), // SignUpPage route
        '/success':(context) => SignSuccess(), // successPage route
        '/emptypreferences':(context) => MyEmptyPreferences(), //emptyPreferences route
        '/notifications':(context) => MyNotifsEmpty(),
        '/editProfile' :(context) => MyEditProfile(),
        '/home' : (context) => MyHome(),

      },
    );
  }
}