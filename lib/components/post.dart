import 'package:flutter/material.dart';
//import 'package:culture_pot/components/my_text_field.dart';
import 'package:culture_pot/components/comment_post.dart';

// ignore: must_be_immutable
class Post extends StatelessWidget {
  TextEditingController commentController = TextEditingController();
  Post({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // You can customize the appearance of the card as needed
      color: Colors.white, // Using the lightest grey available
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Username
            const Text(
              '@username',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 8),

            // Image
            Align(
              alignment: Alignment.center,
              child: Image.asset('lib/images/postEx.png'),
            ),

            const SizedBox(height: 12),

            const Text(
              'My family and I visited the Statue of Unity in Gujarat, India this spring for the first time. I was fascinated at the way locals spoke dialect X of Gujarati while we tourists spoke and learned in dialect Y. Does anyone know why that is?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 12),

            // Add your text field for the post content here
            Comment(
              controller: commentController,
              labelText: "Comment",
              hintText: 'Interact with @username',
              obscureText: false,
            ),
          ],
        ),
      ),
    );
  }
}
