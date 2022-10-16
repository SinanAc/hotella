import 'package:flutter/material.dart';
import 'package:premio_inn/utils/colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key, 
    required this.text,
    this.size = 16,
    this.color = KColors.kBlackColor
    }) : super(key: key);

  final String text;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:  TextStyle(
        color: color,
        fontSize: size, 
        wordSpacing: 1.5,
        ),
    );
  }
}