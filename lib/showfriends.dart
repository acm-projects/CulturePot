import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import your ShowFriendsPage widget here


class ShowFriendsPage extends StatefulWidget {
  @override
  _ShowFriendsPageState createState() => _ShowFriendsPageState();
}

class _ShowFriendsPageState extends State<ShowFriendsPage> {
  List<String> friendsEmails = [];

  @override
  void initState() {
    super.initState();
    // Fetch friends emails when the page is loaded
    fetchFriendsEmails();
  }

Future<void> fetchFriendsEmails() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (userSnapshot.exists) {
      final List<String> friends = List<String>.from(userSnapshot.data()!['friends']); // Assuming 'friends' is the key for the friends list
      // Fetch email for each friend's UID
      for (String friendUID in friends) {
        DocumentSnapshot<Map<String, dynamic>> friendSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(friendUID).get();
        if (friendSnapshot.exists) {
          // If the friend document exists, retrieve the email
          setState(() {
            friendsEmails.add(friendSnapshot.data()!['email']);
          });
        }
      }
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Friends'),
      ),
      body: friendsEmails.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: friendsEmails.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(friendsEmails[index]),
                );
              },
            ),
    );
  }
}
