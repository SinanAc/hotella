import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight weight;
  const TitleWidget({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.fontSize = 20,
    this.weight = FontWeight.w100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color, 
        fontSize: fontSize, 
        fontWeight: FontWeight.bold,
        fontFamily: 'SubMainFont',
        letterSpacing: 1,
        ),
    );
  }
}