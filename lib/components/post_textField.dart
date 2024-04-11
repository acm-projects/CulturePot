import 'package:flutter/material.dart';

class PostText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode focusNode;

  const PostText({
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
        children: [
          Card(
            child: SizedBox(
              height: 200,
              child: Stack(
                children: [
                  const Positioned(
                    left: 16,
                    top: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 20,
                      backgroundImage: AssetImage('imagespot/pfpReal.jpeg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(64, 12, 16,
                        12), // Adjust padding to accommodate the profile picture
                    child: TextField(
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
                  ),
                  Positioned(
                    left: 335,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        // Sending comment here
                      },
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: () {
                        // Sending comment here
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Divider(), // Adding divider below ListTile
        ],
      ),
    );
  }
}
