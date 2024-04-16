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
  @override
  void initState() {
    super.initState();
    widget.numLikes = widget.likes.length; // Initialize numLikes in initState
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                    widget.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 200), // Adjust the spacing between icons
                SaveButton(
                  isSaved: widget.isSaved,
                  onTap: () {
                    setState(() {
                      // Toggle the save button state
                      // You can add your logic here
                    });
                  },
                ),
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
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
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
                const SizedBox(width: 4), // Adjust the spacing between icons
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
                SizedBox(
                  width: 4,
                ), // Adjust the spacing between icons and text
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
