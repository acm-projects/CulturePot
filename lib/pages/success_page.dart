import 'package:culture_pot/components/success_buttons.dart';
//import 'package:culture_pot/pages/empty_preferences.dart';
//import 'package:culture_pot/pages/edit_profilepage.dart';
import 'package:culture_pot/pages/home.dart';
//import 'package:culture_pot/pages/notifsempty_page.dart';

import 'package:flutter/material.dart';

class SignSuccess extends StatelessWidget {
  const SignSuccess({super.key});
  void userSuccess(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHome()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 200,
              ),
              Image.asset(
                'lib/images/success.png',
                height: 170,
              ),
              const SizedBox(height: 15),
              //success text
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Success!",
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
              //Congrats blurb text
              const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35.0),
                  child: Text(
                    "Congratulations! You're now apart of the CulturePot Community. Your personalized cultural experiences await.",
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
              const SizedBox(height: 175),

              MySuccessButton(
                onTap: () => userSuccess(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
