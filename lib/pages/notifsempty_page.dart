import 'package:culture_pot/pages/empy_preferences.dart';
import 'package:culture_pot/pages/homepage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class MyNotifsEmpty extends StatefulWidget {
  const MyNotifsEmpty({Key? key}) : super(key: key);

  @override
  State<MyNotifsEmpty> createState() => _MyNotifsEmptyState();
}

class _MyNotifsEmptyState extends State<MyNotifsEmpty> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
      leading: IconButton(
        onPressed: ()=> Navigator.of(context).push(PageTransition(
                child: MyHome(),
                type: PageTransitionType.fade)),
        icon: Icon(Icons.arrow_back)),
      ),
    backgroundColor:  const Color.fromARGB(255, 233, 230, 230),
    body: SafeArea(
      child: Center(
        child: Column(
          children: <Widget>[
              const SizedBox(height: 200,),
              Image.asset('lib/images/buzz.png',
            height: 170, 
            ),
          //success text
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

          const SizedBox(height: 20,),
          //Congrats blurb text
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