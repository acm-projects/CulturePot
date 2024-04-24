import 'package:flutter/material.dart';

class MyPrefButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;

  const MyPrefButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<MyPrefButton> createState() => _MyPrefButtonState();
}

class _MyPrefButtonState extends State<MyPrefButton> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 120,
        child: FilterChip.elevated(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          selectedColor: Color.fromARGB(255, 247, 192, 25),
          backgroundColor: const Color.fromARGB(255, 233, 230, 230),
          side: const BorderSide(color: Color.fromARGB(255, 103, 102, 102)),
          label: Text(
            widget.text,
            style: TextStyle(fontSize: 16, fontFamily: 'Inter-Regular'),
          ),
          selected: isSelected,
          onSelected: (bool value) {
            setState(() {
              isSelected = !isSelected;
              widget.onPressed(); // Call the onPressed callback
            });
          },
        ),
      ),
    );
  }
}
