import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressItem extends StatelessWidget {
  final String? title;
  final Color? color;
  final String? percentageTitle;
  final double? percent;
  ProgressItem({this.title, this.color, this.percent, this.percentageTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: Text('$title',style: TextStyle(fontSize: 15),),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: new LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 50,
              animation: true,
              barRadius: Radius.circular(10.0),
              lineHeight: 20.0,
              animationDuration: 2000,
              percent: percent!,
              center: Text("%$percentageTitle"),
              progressColor: color
            ),
          ),
        ],
      ),
    );
  }
}