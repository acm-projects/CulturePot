import 'package:culture_pot/pages/comment_page.dart';
import 'package:culture_pot/pages/viewer_profile_page.dart';
import 'package:flutter/material.dart';

class ViewComment extends StatefulWidget {
  final String commentText;
  final String profileImageAsset;
  final String username; // Added username parameter

  const ViewComment({
    Key? key,
    required this.commentText,
    required this.profileImageAsset,
    required this.username, // Added username parameter
  }) : super(key: key);

  @override
  _ViewCommentState createState() => _ViewCommentState();
}

class _ViewCommentState extends State<ViewComment> {
  bool isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 8), // Increased vertical padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 30,
                  backgroundImage: AssetImage(widget.profileImageAsset),
                ),
                const SizedBox(
                  width: 8,
                ), // Add some space between avatar and username
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewerProfilePage(),
                        ),
                      );
                    },
                    child: Text(
                      '@${widget.username}', // Show dynamic username
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              widget.commentText,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
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
                        builder: (context) => CommentPage(),
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
          ),
        ],
      ),
    );
  }
}
