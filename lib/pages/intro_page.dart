import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:culture_pot/pages/sign_uppage.dart';

class Intro extends StatelessWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: AspectRatio(
              aspectRatio:
                  16 / 9, // Replace with the aspect ratio of your animation
              child: SizedBox(
                width: 200, // Adjust width as needed
                height: 200 * (9 / 16), // Maintain aspect ratio
                child: Lottie.asset("imagespot/intro.json",
                    frameRate: FrameRate.max),
              ),
            ),
          )
        ],
      ),
      nextScreen: SignUp(),
      splashIconSize: 10,
      backgroundColor: Color.fromARGB(255, 233, 230, 230),
    );
  }
}
