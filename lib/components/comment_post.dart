import 'package:flutter/material.dart';
class Comment extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode focusNode;

  const Comment({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(focusNode);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            leading: const CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30,
              backgroundImage: AssetImage('lib/images/pfpReal.jpeg'),
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
          const Divider(), // Adding divider below ListTile
        ],
      ),
    );
  }
}
