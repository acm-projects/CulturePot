import 'package:flutter/material.dart';
import 'package:culture_pot/pages/viewer_profile_page.dart';
import 'package:culture_pot/components/save_button.dart';
import 'package:culture_pot/pages/comment_page.dart'; // Import CommentPage here

class CustomPageRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget widget;

  CustomPageRouteBuilder({required this.widget})
      : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 1.0), // Slide up from bottom
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              )),
              child: child,
            );
          },
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
        );
}

class Post extends StatefulWidget {
  final String profileImageAsset;
  final String username;
  final String caption;
  final String likedBy;
  Post({
    Key? key,
    required this.profileImageAsset,
    required this.username,
    required this.caption,
    required this.likedBy,
  }) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isLiked = false;
  bool isSaved = false;

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
                const SizedBox(width: 12),
                const CircleAvatar(
                  backgroundImage: AssetImage('imagespot/pfpReal.jpeg'),
                  radius: 16,
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewerProfilePage(),
                      ),
                    );
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewerProfilePage(),
                      ),
                    );
                  },
                  child: Text(
                    widget.username, // Use the provided username here
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 85),
                SaveButton(
                  isSaved: isSaved,
                  onTap: () {
                    setState(() {
                      isSaved = !isSaved;
                    });
                  },
                )
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.82, // 90% of screen width
                child: Image.asset('imagespot/postEx.png'),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width *
                    0.82, // 90% of screen width
                child: Text(
                  widget.caption, // Use the provided caption here
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
                const SizedBox(
                    width: 4), // Adjust the spacing between icons and text
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewerProfilePage(),
                      ),
                    );
                  },
                  child: Text(
                    widget
                        .likedBy, // Hardcoded username replaced with dynamic username
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Expanded(
                  child: Text(
                    ' and 12 other Partners', // Text for other partners
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
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
