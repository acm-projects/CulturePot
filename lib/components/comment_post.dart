import 'package:flutter/material.dart';

class Comment extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode focusNode;
  final String photoUrl;

  const Comment(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.focusNode,
      required this.photoUrl,
      x})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 25,
              backgroundImage: AssetImage(photoUrl),
            ),
            title: TextField(
              focusNode: focusNode,
              controller: controller,
              autofocus: true,
              obscureText: obscureText,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () {
                // Sending comment here
              },
            ),
          ),
          //Divider(), // Adding divider below ListTile
        ],
      ),
    );
  }
}
