import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/post_card.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<String> friendsUIDs = [];
  List<String> preferences = [];

  @override
  void initState() {
    super.initState();
    // Fetch friends UIDs when the page is loaded
    fetchFriendsUIDs();
    fetchUserPreferences();
  }

  Future<void> fetchFriendsUIDs() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (userSnapshot.exists) {
        final List<String> friends = List<String>.from(userSnapshot.data()![
            'friends']); // Assuming 'friends' is the key for the friends list
        setState(() {
          friendsUIDs = friends;
        });
      }
    }
  }

  Future<void> fetchUserPreferences() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (userSnapshot.exists) {
        final List<String> userPrefs = List<String>.from(userSnapshot.data()![
            'preferences']); // Assuming 'preferences' is the key for the preferences list
        setState(() {
          preferences = userPrefs;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.messenger_outline,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Filter posts made by friends
          final List<DocumentSnapshot> friendPosts = snapshot.data!.docs
              .where((post) => friendsUIDs.contains(post.data()['uid']))
              .toList();

          final List<DocumentSnapshot> culturePosts =
              snapshot.data!.docs.where((post) {
            // Retrieve the culture value from the post
            String culture = post.data()['culture'];

            // Check if the culture value is included in the user's preferences
            return preferences.contains(culture);
          }).toList();

          // Combine friendPosts and culturePosts into a single Set
          Set<DocumentSnapshot> combinedPosts = {};

          // Add friendPosts to the combined set
          combinedPosts.addAll(snapshot.data!.docs
              .where((post) => friendsUIDs.contains(post.data()['uid'])));

          // Add culturePosts to the combined set
          combinedPosts.addAll(snapshot.data!.docs.where((post) {
            String culture = post.data()['culture'];
            return preferences.contains(culture);
          }));

          // Convert the combined set back to a list
          List<DocumentSnapshot> combinedList = combinedPosts.toList();

          return ListView.builder(
            itemCount: combinedList.length, // Use combinedList length
            itemBuilder: (context, index) {
              // Add the print statement here
              print(combinedList[index].data());

              return PostCard(
                snap: combinedList[index]
                    .data(), // Access each post from combinedList
              );
            },
          );
        },
      ),
    );
  }
}
