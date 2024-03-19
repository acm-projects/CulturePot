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

  @override
  void initState() {
    super.initState();
    // Fetch friends UIDs when the page is loaded
    fetchFriendsUIDs();
  }

  Future<void> fetchFriendsUIDs() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userSnapshot.exists) {
        final List<String> friends = List<String>.from(userSnapshot.data()!['friends']); // Assuming 'friends' is the key for the friends list
        setState(() {
          friendsUIDs = friends;
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

          return ListView.builder(
            itemCount: friendPosts.length,
            itemBuilder: (context, index) {
              // Add the print statement here
              print(friendPosts[index].data());

              return PostCard(
                snap: friendPosts[index].data(),
              );
            },
          );
        },
      ),
    );
  }
}
