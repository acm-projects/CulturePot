//import 'package:culture_pot/pages/notifsempty_page.dart';
import 'package:culture_pot/pages/preferences_page.dart';
//import 'package:culture_pot/pages/viewer_profile_page.dart';
import 'package:flutter/material.dart';
//import 'package:page_transition/page_transition.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:culture_pot/pages/search_page.dart';
import 'package:culture_pot/pages/user_profile_page.dart';

class MyNotifsEmpty extends StatefulWidget {
  const MyNotifsEmpty({Key? key}) : super(key: key);

  @override
  State<MyNotifsEmpty> createState() => _MyNotifsEmptyState();
}

class _MyNotifsEmptyState extends State<MyNotifsEmpty> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 230, 230),
        title: Image.asset('imagespot/logo.png', height: 90),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 9.0),
          //   child: IconButton(
          //     onPressed: () => Navigator.of(context).push(
          //       PageTransition(
          //           child: MyNotifsEmpty(), type: PageTransitionType.fade),
          //     ),
          //     icon: const Icon(
          //       Icons.favorite_border_rounded,
          //       size: 35.0,
          //     ),
          //   ),
          // ),
          
        ],
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
                'lib/images/buzz.png',
                height: 170,
              ),
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "No Buzz!",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                      fontFamily: 'Alike',
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Text(
                    "You have no current notifications",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: 'Alike',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 220),
            ],
          ),
        ),
      ),
    );
  }
}