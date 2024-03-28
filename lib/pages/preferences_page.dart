import 'package:flutter/material.dart';
import 'package:culture_pot/components/preference_card.dart';
import 'package:culture_pot/pages/preference_info.dart'; // Import the page you want to navigate to

class PreferencesPage extends StatelessWidget {
  const PreferencesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferences'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const PreferenceInfo()), // Navigate to the preference_info.dart page
          );
        },
        child: Preference(), // No need to wrap with GestureDetector
      ),
    );
  }
}