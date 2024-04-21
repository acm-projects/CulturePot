import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Culture Phrasebook',
      home: CulturePhrasebookForm(),
    );
  }
}

class CulturePhrasebookForm extends StatefulWidget {
  @override
  _CulturePhrasebookFormState createState() => _CulturePhrasebookFormState();
}

class _CulturePhrasebookFormState extends State<CulturePhrasebookForm> {
  String _selectedCulture = ''; // Variable to hold the selected culture
  List<String> _cultures = []; // List to hold fetched cultures

  final TextEditingController _phraseController = TextEditingController();
  final TextEditingController _exampleSentenceController = TextEditingController();
  final TextEditingController _translationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCultures(); // Fetch cultures when the widget initializes
  }

  Future<void> _fetchCultures() async {
    final user = FirebaseAuth.instance.currentUser;
    final preferencesSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('posts').get();
    Set<String> cultureSet = Set();
    snapshot.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      final culture = doc['culture'] as String?;
      if (culture != null &&
          culture.isNotEmpty){
        cultureSet.add(culture);
      }
    });
    setState(() {
      _cultures = cultureSet.toList(); // Update the list of cultures
      if (_cultures.isNotEmpty) {
        _selectedCulture = _cultures[0]; // Set the selected culture to the first culture fetched
      }
    });
  }

  Future<void> _submitPhrase() async {
    final String phrase = _phraseController.text;
    final String exampleSentence = _exampleSentenceController.text;
    final String translation = _translationController.text;

    if (phrase.isEmpty || exampleSentence.isEmpty || translation.isEmpty || _selectedCulture.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill out all fields.'),
      ));
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    final uid = user!.uid;

    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      await firestore.collection('idioms').add({
        'Culture': _selectedCulture,
        'Phrase': phrase,
        'Sentence': exampleSentence,
        'Translation': translation,
        'userId': uid,
        'timestamp': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Phrase submitted successfully!'),
      ));

      // Clear text fields after successful submission
      _phraseController.clear();
      _exampleSentenceController.clear();
      _translationController.clear();
    } catch (e) {
      print('Error submitting phrase: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error submitting phrase. Please try again later.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Culture Phrasebook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField(
              value: _selectedCulture,
              items: _cultures.map((culture) {
                return DropdownMenuItem(
                  value: culture,
                  child: Text(culture),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  _selectedCulture = value ?? ''; // Update the selected culture
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Culture',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phraseController,
              decoration: InputDecoration(labelText: 'Enter Phrase in English'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _exampleSentenceController,
              decoration: InputDecoration(labelText: 'Example Sentence'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _translationController,
              decoration: InputDecoration(labelText: 'Translation'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _submitPhrase,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
