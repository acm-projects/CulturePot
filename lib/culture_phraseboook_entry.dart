import 'package:culture_pot/pages/culture_phrasebook.dart';
import 'package:culture_pot/search_phrase.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Culture Phrasebook',
      home: CulturePhrasebookEntryPage(),
    );
  }
}

class CulturePhrasebookEntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Culture Phrasebook Entry'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the page for entering a new phrase
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CulturePhrasebookForm()),
                );
              },
              child: Text('Enter a New Phrase'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the page for searching phrases
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPhrase()),
                );
              },
              child: Text('Search for a Phrase'),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPhrasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search for Phrase'),
      ),
      body: Center(
        child: Text('Search Phrase Form'),
      ),
    );
  }
}
