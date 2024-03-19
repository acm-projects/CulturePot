import 'package:culture_pot/culture_feed.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CulturePage extends StatelessWidget {
  const CulturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cultures'),
      ),
      body: FutureBuilder(
        future: _fetchCultures(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final cultures = snapshot.data!;
            return ListView.builder(
              itemCount: cultures.length,
              itemBuilder: (context, index) {
                final culture = cultures[index];
                return ListTile(
                  title: ElevatedButton(
                   onPressed: () {
  // Navigate to a different page and pass the selected culture as a parameter
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CultureScreen(selectedCulture: culture),
    ),
  );
},

                    child: Text(culture),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<String>> _fetchCultures() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('posts').get();
    Set<String> cultureSet = Set();
    snapshot.docs.forEach((QueryDocumentSnapshot<Map<String, dynamic>> doc) {
      final culture = doc['culture'] as String?;
      if (culture != null && culture.isNotEmpty) {
        cultureSet.add(culture);
      }
    });
    return cultureSet.toList();
  }
}

class CultureDetailPage extends StatelessWidget {
  final String culture;

  const CultureDetailPage({Key? key, required this.culture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Culture Details'),
      ),
      body: Center(
        child: Text('Culture: $culture'),
      ),
    );
  }
}
