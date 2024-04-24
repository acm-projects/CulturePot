import 'package:flutter/material.dart';

class MyDropdownButton extends StatefulWidget {
  final Function(String)
      onSelected; // Callback to pass the selected value to the parent
  const MyDropdownButton({Key? key, required this.onSelected})
      : super(key: key);

  @override
  State<MyDropdownButton> createState() => _MyDropdownButtonState();
}

class _MyDropdownButtonState extends State<MyDropdownButton> {
  String dropdownValue = 'Nigeria'; // Default value

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
        style: const TextStyle(color: Colors.black),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          widget.onSelected(newValue!); // Call the callback with new value
        },
        items: const [
          DropdownMenuItem<String>(child: Text('Cultures'), value: 'Cultures'),
          DropdownMenuItem<String>(child: Text('Mexican'), value: 'Mexican'),
          DropdownMenuItem<String>(child: Text('Indian'), value: 'Indian'),
          DropdownMenuItem<String>(child: Text('German'), value: 'German'),
          DropdownMenuItem<String>(child: Text('Japanese'), value: 'Japanese'),
          DropdownMenuItem<String>(child: Text('Africa'), value: 'Nigeria'),
          DropdownMenuItem<String>(child: Text('Nigerian'), value: 'Nigerian'),
          DropdownMenuItem<String>(child: Text('Thai'), value: 'Thai'),
        ],
      ),
    );
  }
}
