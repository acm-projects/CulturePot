// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:culture_pot/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostText extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode focusNode;
  final String photoUrl;
  final Function(Uint8List?) onFileUploaded; // Callback function
  Uint8List? _file;

  PostText({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.focusNode,
    required this.photoUrl,
    required this.onFileUploaded,
  }) : super(key: key);

  Uint8List? getFile() {
    if (_file != null) {
      return _file;
    }
    return null;
  }

  @override
  _PostTextState createState() => _PostTextState();
}

class _PostTextState extends State<PostText> {
  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(title: const Text('Create a Post'), children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Take a photo"),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.camera,
                );
                setState(() {
                  widget._file = file;
                  widget.onFileUploaded(file); // Call the callback function
                });
              },
            ),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text("Choose from gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    widget._file = file;
                    widget.onFileUploaded(file); // Call the callback function
                  });
                }),
          ]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(widget.focusNode);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 20,
                      backgroundImage: AssetImage(widget.photoUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(64, 12, 16,
                        12), // Adjust padding to accommodate the profile picture
                    child: TextField(
                      focusNode: widget.focusNode,
                      controller: widget.controller,
                      autofocus: true,
                      obscureText: widget.obscureText,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: widget.hintText,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // right icon
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
                  //left icon
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: () {
                        // Sending comment here
                        _selectImage(context);
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
