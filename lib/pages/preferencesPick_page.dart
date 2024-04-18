import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/pages/success_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/pref_buttons.dart';
import 'package:culture_pot/components/pref_buttons2.dart';

class MyPreferences extends StatefulWidget {
  const MyPreferences({Key? key}) : super(key: key);

  @override
  _MyPreferencesState createState() => _MyPreferencesState();
}

class _MyPreferencesState extends State<MyPreferences> {
  List<String> selectedPreferences = [];

  void userNext(BuildContext context) async {
    // Add the selected preferences to Firestore
    await addPreferencesToFirestore(selectedPreferences);

    // Navigate to the success page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignSuccess(),
      ),
    );
  }

  Future<void> addPreferencesToFirestore(List<String> preferences) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Update user preferences in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .update({'preferences': preferences});
    } catch (error) {
      print('Error adding preferences: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 233, 230, 230),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "  Cultural preferences 🌍",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Inter-Regular',
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Tell us your cultural preferences, and we will add it to your Culture Pot! Don't worry, you can always change it later in the settings.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      fontFamily: 'Alike',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        MyPrefButton(
                          text: 'Mexican 🇲🇽',
                          onPressed: () {
                            setState(() {
                              selectedPreferences.add('Mexican');
                            });
                          },
                        ),
                        const SizedBox(width: 5),
                        MyPrefButton(
                          text: 'Indian 🇮🇳',
                          onPressed: () {
                            setState(() {
                              selectedPreferences.add('Indian');
                            });
                          },
                        ),
                        MyPrefButton(
                          text: 'Eritrean 🇪🇷',
                          onPressed: () {
                            setState(() {
                              selectedPreferences.add('Eritrean');
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        MyPrefButton(
                          text: 'France 🇫🇷',
                          onPressed: () {
                            setState(() {
                              selectedPreferences.add('France');
                            });
                          },
                        ),
                        const SizedBox(width: 2),
                        MyPrefButton(
                          text: 'Japanese 🇯🇵',
                          onPressed: () {
                            setState(() {
                              selectedPreferences.add('Japanese');
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        MyPrefButton(
                          text: 'Nigerian 🇳🇬',
                          onPressed: () {
                            setState(() {
                              selectedPreferences.add('Nigerian');
                            });
                          },
                        ),
                        MyPrefButton(
                          text: 'China 🇨🇳',
                          onPressed: () {
                            setState(() {
                              selectedPreferences.add('China');
                            });
                          },
                        ),
                        MyPrefButton(
                          text: 'Thailand 🇹🇭',
                          onPressed: () {
                            setState(() {
                              selectedPreferences.add('Thailand');
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        MyPrefButton(
                          text: 'German 🇩🇪',
                          onPressed: () {
                            setState(() {
                              selectedPreferences.add('German');
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        MyPrefButton(
                          text: 'Others...',
                          onPressed: () {
                            // Implement logic for 'Others...' button
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
              MyPrefButton2(
                onTap: () => userNext(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
