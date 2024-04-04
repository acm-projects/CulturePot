import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:culture_pot/components/duolingo_card.dart';

class PreferenceInfo extends StatelessWidget {
  const PreferenceInfo({Key? key}) : super(key: key);

  _launchURL() async {
    const url = 'https://www.duolingo.com/course/hi/en/Learn-Hindi';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(500), // Set the height of the app bar
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/taj.png'),
                  fit: BoxFit
                      .cover, // Cover the entire app bar area with the image
                ),
              ),
            ),
            AppBar(
              backgroundColor:
                  Colors.transparent, // Make the app bar transparent
              elevation: 0, // Remove the app bar shadow
              title: const Text('Preferences'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(
                        context); // Navigate back to the previous screen
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.lightBlue[100], // Set background color of the body
        child: Column(
          children: [
            // You can add additional content here
            Duolingo(
              onTap:
                  _launchURL, // Pass the _launchURL function to Duolingo widget
            ),

            const Text('Learn',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }
}
