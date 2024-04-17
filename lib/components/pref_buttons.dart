import 'package:flutter/material.dart';

class MyPrefButton extends StatefulWidget {
  final String text;

  const MyPrefButton({Key? key, required this.text}) : super(key: key);

  @override
  State<MyPrefButton> createState() => _MyPrefButtonState();
}

class _MyPrefButtonState extends State<MyPrefButton> {
  bool isSelected = false;
  late String text; // Declare text variable here

  @override
  void initState() {
    super.initState();
    text =
        widget.text; // Initialize text with the value passed from constructor
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 118,
        child: FilterChip.elevated(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          selectedColor: Color.fromARGB(255, 247, 192, 25),
          backgroundColor: const Color.fromARGB(255, 233, 230, 230),
          side: const BorderSide(color: Color.fromARGB(255, 103, 102, 102)),
          label: Text(
            text,
            style: TextStyle(fontSize: 16, fontFamily: 'Inter-Regular'),
          ),
          selected: isSelected,
          onSelected: (bool value) {
            setState(() {
              isSelected = !isSelected;
            });
          },
        ),
      ),
    );
  }
}
