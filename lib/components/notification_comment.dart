import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:culture_pot/pages/comment_page.dart';
import 'package:culture_pot/pages/viewer_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/pages/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:culture_pot/components/save_button.dart';

class NotifComment extends StatefulWidget {
  final String commentText;
  final String profileImageAsset;
  final String username;

  NotifComment({
    Key? key,
    required this.commentText,
    required this.profileImageAsset,
    required this.username,
  }) : super(key: key);

  @override
  _NotifCommentState createState() => _NotifCommentState();
}

class _NotifCommentState extends State<NotifComment> {
  bool isLiked = false;
  String uid = "";

  Future<void> findUidByUsername() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: widget.username)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      setState(() {
        uid = querySnapshot.docs.first.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 16,
                    backgroundImage: AssetImage(widget.profileImageAsset),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewerProfilePage(uid: uid),
                        ),
                      );
                    },
                    child: Text(
                      '@${widget.username}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 9),
              const SizedBox(width: 100),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.83, // Adjust the width as needed
                  child: Text(
                    widget.commentText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.comment,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CommentPage(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}