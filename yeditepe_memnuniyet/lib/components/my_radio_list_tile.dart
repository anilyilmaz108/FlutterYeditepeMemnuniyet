import 'package:flutter/material.dart';

class MyRadioListTile extends StatelessWidget {
  final String? character;
  final void Function(String? value)? onPressed;
  final String? value;
  final String? title;
  final Widget? widget;



  MyRadioListTile({this.character, this.onPressed, this.value, this.title, this.widget});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(32)),
        child: RadioListTile<String>(
          title: Text('$title'),
          //tileColor: Colors.white,
          selectedTileColor: Colors.blue,
          activeColor: Colors.blue,
          value: '$value',
          groupValue: character,
          onChanged: onPressed,
          secondary: widget,
        ),
      ),
    );
  }
}
