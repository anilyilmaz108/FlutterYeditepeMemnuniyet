import 'package:flutter/material.dart';

class ItemRow extends StatelessWidget {
  final String? title;
  final Color? color;
  ItemRow({this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(shape: BoxShape.circle, color: color,),),
          SizedBox(width: 5,),
          Text('$title')
        ],
      ),
    );
  }
}