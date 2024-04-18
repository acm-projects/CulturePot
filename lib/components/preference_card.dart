import 'package:flutter/material.dart';
import 'package:culture_pot/pages/preference_info.dart';

class Preference extends StatelessWidget {
  final String photoUrl;
  final String name;

  Preference({
    Key? key,
    required this.photoUrl,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PreferenceInfo(),
          ),
        );
      },
      child: SizedBox(
        height: 100, // Adjust the height as needed
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                // Image with rounded edges
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10), // Adjust border radius as needed
                  child: Image.asset(
                    photoUrl,
                    width: 120, // Adjust width as needed
                    height: 150, // Adjust height as needed
                  ),
                ),
                const SizedBox(
                    width: 16), // Adjust spacing between image and text

                // Text
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ), // Adjust text size as needed
                  ),
                ),

                // Rightward arrow
                const Icon(Icons.arrow_forward),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
