import 'package:flutter/material.dart';
import 'package:culture_pot/pages/viewer_profile_page.dart';
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
  Post({Key? key}) : super(key: key);

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool isLiked = false;

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
                const CircleAvatar(
                  backgroundImage: AssetImage('lib/images/pfpReal.jpeg'),
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
                  child: const Text(
                    'username',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 44),
                const SizedBox(
                  width: 4,
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width:
                    MediaQuery.of(context).size.width * 0.85, // 90% of screen w
                child: Image.asset('lib/images/postEx.png'),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width:
                    MediaQuery.of(context).size.width * 0.83, // 90% of screen w
                child: const Text(
                  'My family and I visited the Statue of Unity in Gujarat, India this spring for the first time. I was fascinated at the way locals spoke dialect X of Gujarati while we tourists spoke and learned in dialect Y. Does anyone know why that is?',
                  style: TextStyle(
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
                    'vidurnangia',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                const Text(
                  'and 12 other Partners',
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
