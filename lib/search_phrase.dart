import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Culture Phrasebook',
      home: SearchPhrase(),
    );
  }
}

class SearchPhrase extends StatefulWidget {
  @override
  _SearchPhraseState createState() => _SearchPhraseState();
}

class _SearchPhraseState extends State<SearchPhrase> {
  TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  List<Map<String, dynamic>> _searchResults = [];

Future<void> _searchPhrases(String searchTerm) async {
  if (searchTerm.isEmpty) {
    setState(() {
      _searchResults = []; // Clear search results if search term is empty
    });
    return;
  }

  final CollectionReference phrasesRef = FirebaseFirestore.instance.collection('idioms');

  final QuerySnapshot<Object?> snapshot = await phrasesRef.get();

  final List<Map<String, dynamic>> startsWithSearchTerm = [];
  final List<Map<String, dynamic>> containsSearchTerm = [];

  final lowerSearchTerm = searchTerm.toLowerCase();

  snapshot.docs.forEach((doc) {
    final phraseData = doc.data() as Map<String, dynamic>;
    final phrase = phraseData['Phrase'] as String?;
    if (phrase != null) {
      final lowerPhrase = phrase.toLowerCase();
      if (lowerPhrase.startsWith(lowerSearchTerm)) {
        startsWithSearchTerm.add(phraseData);
      } else if (lowerPhrase.contains(lowerSearchTerm)) {
        containsSearchTerm.add(phraseData);
      }
    }
  });

  startsWithSearchTerm.sort((a, b) => a['Phrase'].compareTo(b['Phrase']));
  containsSearchTerm.sort((a, b) => a['Phrase'].compareTo(b['Phrase']));

  setState(() {
    _searchResults = [...startsWithSearchTerm, ...containsSearchTerm]; // Store sorted search results
  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Phrases'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a phrase...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
                _searchPhrases(_searchTerm);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final phraseData = _searchResults[index];
                return ListTile(
                  title: Text('Phrase: ${phraseData['Phrase']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Culture: ${phraseData['Culture']}'),
                      Text('Example Sentence: ${phraseData['Sentence']}'),
                      Text('Translation: ${phraseData['Translation']}'),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
