import 'package:flutter/material.dart';
import 'package:culture_pot/pages/viewer_profile_page.dart';
import 'package:culture_pot/components/save_button.dart';
import 'package:culture_pot/pages/comment_page.dart'; // Import CommentPage here
import 'package:cloud_firestore/cloud_firestore.dart';

class Post extends StatefulWidget {
  final String username;
  final String pfp;
  final List<dynamic> likes; // Change type to List<dynamic>
  late int numLikes; // Change to late to allow initialization in initState
  final String imageUrl;
  final String description;
  final bool isLiked;
  final bool isSaved;

  Post({
    Key? key,
    required this.pfp,
    required this.likes, // Change to List<dynamic>
    required this.username,
    required this.imageUrl,
    required this.description,
    required this.isLiked,
    required this.isSaved,
  }) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  String uid = '';

  @override
  void initState() {
    super.initState();
    widget.numLikes = widget.likes.length; // Initialize numLikes in initState
    findUidByUsername();
  }

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
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(4.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.pfp,
                  ),
                  radius: 16,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    if (uid.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewerProfilePage(uid: uid),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    '@',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    if (uid.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewerProfilePage(uid: uid),
                        ),
                      );
                    }
                  },
                  child: Text(
                    widget.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 85),
                SaveButton(
                  isSaved: widget.isSaved,
                  onTap: () {
                    setState(() {
                      // Toggle the save button state
                      // You can add your logic here
                    });
                  },
                )
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width:
                    MediaQuery.of(context).size.width * 0.85, // 90% of screen w
                child: Image.network(widget.imageUrl),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width:
                    MediaQuery.of(context).size.width * 0.83, // 90% of screen w
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
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
                      CustomPageRouteBuilder(
                        widget: const CommentPage(),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(
                    widget.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: widget.isLiked ? Colors.red : Colors.black,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      // Toggle the like button state
                      // You can add your logic here
                    });
                  },
                ),
                const SizedBox(
                    width: 4), // Adjust the spacing between icons and text
                GestureDetector(
                  onTap: () async {
                    if (uid.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewerProfilePage(uid: uid),
                        ),
                      );
                    }
                  },
                  child: Text(
                    widget.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  width: 4,
                ), // Adjust the spacing between text and "and"
                Text(
                  'and ${widget.numLikes} other Partners',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
