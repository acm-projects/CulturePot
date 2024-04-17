import 'package:culture_pot/pages/edit_profilepage.dart';
import 'package:culture_pot/pages/empty_preferences.dart';
import 'package:culture_pot/pages/home.dart';
import 'package:culture_pot/pages/notifsempty_page.dart';
import 'package:culture_pot/pages/sign_uppage.dart';
import 'package:culture_pot/pages/success_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/pages/preferencesPick_page.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:culture_pot/pages/intro_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ////wait Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Set the initial route
      routes: {
        '/': (context) => Intro(), // signUp as the initial route
        '/sign up': (context) => SignUp(),
        '/preferences': (context) => MyPreferences(), // SignUpPage route
        '/success': (context) => SignSuccess(), // successPage route
        '/emptypreferences': (context) =>
            MyEmptyPreferences(), //emptyPreferences route
        '/notifications': (context) => MyNotifsEmpty(),
        '/editProfile': (context) => MyEditProfile(),
        '/home': (context) => MyHome(),
      },
    );
  }
}
