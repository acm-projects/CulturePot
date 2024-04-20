import 'package:flutter/material.dart';
import 'package:culture_pot/services/firestore.dart';

class Comment extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final FocusNode focusNode;
  final String postID;
  final String uid;
  final String username;
  final String photoUrl;
  final TextEditingController controller;

  const Comment({
    Key? key,
    required this.hintText,
    required this.obscureText,
    required this.focusNode,
    required this.postID,
    required this.uid,
    required this.username,
    required this.photoUrl,
    required this.controller,
  }) : super(key: key);

  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {
  void postComment() async {
    try {
      String res = await FirestoreService().postComment(
        widget.postID, // Accessing variables via widget
        widget.controller.text,
        widget.uid,
        widget.username,
        widget.photoUrl,
      );

      if (res == 'success') {
        if (mounted) {
          setState(() {
            widget.controller
                .clear(); // Clear the text field on successful post
          });
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(res)));
        }
      }
    } catch (err) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(err.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: "Write a comment...",
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          onPressed: postComment, // Call the postComment method on button press
        ),
      ),
    );
  }
}
