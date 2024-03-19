import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:culture_pot/post_card.dart';

class CultureScreen extends StatefulWidget {
  final String selectedCulture; // Add selectedCulture parameter

  const CultureScreen({Key? key, required this.selectedCulture}) : super(key: key);

  @override
  _CultureScreenState createState() => _CultureScreenState();
}

class _CultureScreenState extends State<CultureScreen> {
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
      body: Column(
        children: [
          // No need for DropdownButton since the selected culture is already provided
          // Display selected culture instead
          Text('Selected Culture: ${widget.selectedCulture}'),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('posts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Filter posts based on the selected culture
                final List<DocumentSnapshot> culturePosts = snapshot.data!.docs
                    .where((post) => post.data()['culture'] == widget.selectedCulture)
                    .toList();

                return ListView.builder(
                  itemCount: culturePosts.length,
                  itemBuilder: (context, index) {
                    return PostCard(
                      snap: culturePosts[index].data(),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
