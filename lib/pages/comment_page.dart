import 'package:flutter/material.dart';
import 'package:culture_pot/components/comment_sheet.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('lib/images/logo.png', height: 90),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Pop back when the back button is pressed
          },
        ),
      ),
      body: CommentSheet(),
    );
  }
}
